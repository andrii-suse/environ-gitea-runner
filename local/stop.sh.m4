if [ -f __workdir/.pid ]; then
    kill $(cat __workdir/.pid)
    rm __workdir/.pid
fi
