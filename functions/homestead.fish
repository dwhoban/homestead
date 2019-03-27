function homestead -d "Global function for Laravel Homestead"
    set DIR $PWD
    set -q HOMESTEAD_PATH || set -Ux HOMESTEAD_PATH ~/Homestead
    cd $HOMESTEAD_PATH
    eval vagrant $argv
    cd $DIR
end
