(
cd __workdir
gitea-action-runner -c __workdir/config.toml daemon 2>>.cerr >>.cout &
pid=$!

echo $pid > __workdir/.pid
)
