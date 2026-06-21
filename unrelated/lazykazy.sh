set -e
cd "$(dirname "$0")"
cd "../main things"
mkdir build
cp "BFDI Branches.zip" build
cd build
unzip "BFDI Branches.zip"
cd "BFDI Branches.app/Contents/Resources"
curl -o "BFDI Branches.pck" https://bfdibranches.com/bfdibranches.pck
cd ../../..
echo 'From this folder, run `xattr -cr BFDI\ Branches.app` in Terminal to allow MacOS to open it.' > README.txt
zip -r -q branches.zip "BFDI Branches.app" README.txt
mv branches.zip ../..
echo ok
