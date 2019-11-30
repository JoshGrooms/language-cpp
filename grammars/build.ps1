$env:NODE_PATH = ((npm config get prefix) + "\node_modules")
coffee ./coffee/main.coffee | Out-File cpp.cson -encoding ASCII
echo $NODE_PATH
