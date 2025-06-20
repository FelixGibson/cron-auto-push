#!/bin/bash

LOCAL_REPO="/home/felix/software/git-felix/Dropbox"
POCKET_PARSER="/home/felix/software/git-felix/raindrop-rs"
export PATH="/home/felix/.nvm/versions/node/v16.14.0/bin:$PATH"

cd $LOCAL_REPO

date_var="$(date)"
date_var="${date_var// /-}" # replaces all spaces with dashes
log_file="/home/felix/log/$date_var.log"
mkdir -p "/home/felix/log" && touch $log_file
day="${log_file:0:14}" # gets the first 10 characters of string

containsLogFromToday=0

add_commit_push()
{
    echo "-------ADD COMMENTS-------" >> "$log_file"
    git add * >> "$log_file"
    echo "-------COMMIT COMMENTS-------" >> "$log_file"
    git commit -a -m "Auto-commit at $date_var" >> "$log_file"
    echo "-------PUSH COMMENTS-------" >> "$log_file"
    git push  >> "$log_file"
    cd $POCKET_PARSER
    echo "-------POCKET PARSER-------" >> "$log_file"
    /home/felix/.cargo/bin/cargo run  >> "$log_file" 2>> "$log_file"
}


check_for_auto_commit()
{
    for filename in log/*.log; do
        fileday=${filename:0:14}
        if [[ $fileday == $day ]] && [[ $1 != "-o" ]]; then # $1 is the first command-line argument, like sys.argv[1] in python
            containsLogFromToday=1
            break
        fi
    done
}

add_commit_push
exit 1



