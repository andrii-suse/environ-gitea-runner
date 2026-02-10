(
cd __workdir
gitea-action-runner -c __workdir/config.toml register --instance "$1" --token "$2" --no-interactive 2>> .cerrreg  >> .coutreg  
)
