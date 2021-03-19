function mcd --description 'Make a directory and change the current working dir to the new one'
    mkdir -pv $argv;
    cd $argv;
end
