T=$(which vsce)
if [ -z "$T" ]; then
	T1=$(which npm)
	if [ -z "$T1" ]; then
		echo "Install Node.js and try again."
	else
		npm install -g @vscode/vsce
		echo "Install vscode/vsce done, run this script again"
	fi
else
	vsce package
fi
