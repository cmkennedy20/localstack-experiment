#/bin/bash
cd ./terraform/
[[ -f ./lambda.zip ]] && rm -r ./lambda.zip 
tflocal init 
tflocal apply --auto-approve
