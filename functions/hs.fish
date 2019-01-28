function hs -d "Global function for Laravel Homestead"
    set DIR $PWD
    cd ~/Homestead
    eval vagrant $argv
    cd $DIR
end
