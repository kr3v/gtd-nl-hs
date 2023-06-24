import axios from 'axios';
import * as vscode from 'vscode';
import path = require('path/posix');
import fs = require('node:fs');
import { exec, spawn } from 'child_process';
import { homedir } from 'os'


const userHomeDir = homedir();
const serverRoot = path.join(userHomeDir, "/.local/share/haskell-gtd-extension-server-root");
const serverExe = "haskell-gtd-server";
const serverPidF = path.join(serverRoot, 'pid');
const serverPortF = path.join(serverRoot, 'port');
let port = 0;

function isParentOf(p1: string, p2: string) {
	const relative = path.relative(p1, p2);
	return relative && !relative.startsWith('..') && !path.isAbsolute(relative);
}

class XDefinitionProvider implements vscode.DefinitionProvider {
	async provideDefinition(
		document: vscode.TextDocument,
		position: vscode.Position,
		token: vscode.CancellationToken
	): Promise<vscode.Definition> {
		let range = document.getWordRangeAtPosition(position);
		let word = document.getText(range);

		console.log("%s", word);

		fs.readFile(serverPortF, "utf8", (err, data) => {
			let pid = parseInt(data, 10);
			port = pid;
		});

		if (port > 0 && vscode.workspace.workspaceFolders) {
			let workspaceFolder = vscode.workspace.workspaceFolders[0];
			let workspacePath = workspaceFolder.uri.fsPath;
			let docPath = document.uri.fsPath;
			
			if (!isParentOf(workspacePath, docPath)) {
				console.log("workspacePath is not parent of docPath, this case is broken right now");
				return Promise.resolve([]);
			}

			let body = {
				workDir: workspacePath,
				file: docPath,
				word: word
			};
			let res = await axios.
				post(`http://localhost:${port}/definition`, body).
				catch(function (error) {
					console.log("for body {body}");
					console.log(error);
					return { "data": {} };
				});
			let data = res.data;
			if (data.err != "" && data.err != undefined) {
				console.log("%s -> err:%s", word, data.err);
				return Promise.resolve([]);
			}

			let filePath = data.srcSpan.sourceSpanFileName;
			let fileUri = vscode.Uri.file(path.normalize(filePath));

			let line = data.srcSpan.sourceSpanStartLine - 1; // 0-based line number
			let character = data.srcSpan.sourceSpanStartColumn - 1; // 0-based character position
			let definitionPosition = new vscode.Position(line, character);
			let definitionLocation = new vscode.Location(fileUri, definitionPosition);

			console.log(filePath);
			return Promise.resolve(definitionLocation);
		}
		return Promise.resolve([]);
	}
}

export function activate(context: vscode.ExtensionContext) {
	console.log('Congratulations, your extension "hs-gtd" is now active!');
	console.log(userHomeDir);

	const stdout = fs.openSync(path.join(serverRoot, 'stdout.log'), 'a');
	const stderr = fs.openSync(path.join(serverRoot, 'stderr.log'), 'a');
	let server = spawn(path.join(serverRoot, serverExe), {
		detached: true,
		stdio: ['ignore', stdout, stderr],
	});

	context.subscriptions.push(
		vscode.languages.registerDefinitionProvider(
			{ scheme: 'file', language: 'haskell' },
			new XDefinitionProvider()
		)
	);
}

// This method is called when your extension is deactivated
export async function deactivate() {
	console.log("deactivating...");
	fs.readFile(serverPidF, "utf8", (err, data) => {
		let pid = parseInt(data, 10);
		console.log(`killing ${pid}`);
		exec(`kill -9 ${pid}`);
	});
}
