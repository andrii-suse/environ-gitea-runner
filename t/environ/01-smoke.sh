#!lib/test-in-container-environ.sh
set -exo pipefail

gt=$(environ gt)

$gt/start
$gt/status
$gt/admin/create
$gt/bob/create

token=$($gt/create_runner_token)

gr=$(environ gr)

$gr/gen_env
$gr/register http://$($gt/print_address) $token
$gr/start

$gt/admin/create_org bob bobshome
$gt/admin/create_repo bobshome myrepo1

(
mkdir $gt/bob/work
cd $gt/bob/work
git clone http://$(cat $gt/bob/token.txt)@$($gt/print_address)/bobshome/myrepo1
cd myrepo1
git checkout -b main
echo README > README.txt
mkdir -p .gitea/workflows/

echo "
name: t

on:
  push:
    branches: ['main']
  workflow_dispatch:

jobs:
  t:
    runs-on: myrunner1
    steps:
      - name: os-release
        run: cat /etc/os-release
      - name: Start a podman container
        run: bash -x -c 'podman run --rm tumbleweed cat /etc/os-release'
      - name: Start a privileged podman container
        run: bash -x -c 'podman run --rm --privileged tumbleweed cat /etc/os-release'
" > .gitea/workflows/t.yaml

git add README.txt .gitea
git config user.name "Geeko Packager"
git config user.email "email@example.com"

git commit -m 'Add README.txt'
git push origin main
)


sleep 5
while $gt/bob/curl_get /api/v1/repos/bobshome/myrepo1/actions/runs/1 | jq | grep -E 'status' | grep 'in_progress'; do
    sleep 2
done

$gt/bob/curl_get /api/v1/repos/bobshome/myrepo1/actions/runs/1 | jq | grep -E 'conclusion'

$gt/print_address

echo success
