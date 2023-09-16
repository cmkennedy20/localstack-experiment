#/bin/bash
cd ./terraform/
[[ -f lambda.zip ]] && rm -r lambda.zip;
zip lambda.zip ../code/lambda.py
tflocal init 
tflocal apply --auto-approve
