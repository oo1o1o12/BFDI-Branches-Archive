set -e
cd "$(dirname "$0")"
curl -o "BFDI Branches.pck" https://bfdibranches.com/new/bfdibranches.pck
zip -r -q branches.zip "BFDI Branches.pck"
echo ok