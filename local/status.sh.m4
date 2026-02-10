
if [ -f __workdir/.pid ]; then
    if ps -p $(cat __workdir/.pid) > /dev/null; then
        echo "gitea-runner is running"
    else
        echo "gitea-runner is not running, but pidfile exists"
    fi
else
    echo "gitea-runner is not running"
fi
