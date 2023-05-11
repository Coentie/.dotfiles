#!/usr/bin/sh

## Copy zsh profile 
mkdir -p ./zsh
cp ~/.zshrc ./zsh/.zshrc

mkdir -p ./ssh
cp ~/.ssh/id_rsa.pub ./ssh

#Setting up encrypted ssh keys
mkdir -p ./passphrase
mkdir -p ./encrypted
read -sp "Enter the passphrase for the vault: " VAULT_PASSPHRASE
echo "$VAULT_PASSPHRASE" >> ./passphrase/pass.txt
echo ""

if [ -x "$(command -v docker)" ]; then
    cp docker.templ Dockerfile
    docker build . -t ansible-vault-keys
    for f in "./ssh/*"
    do 
        NAME=$(basename $f)
        OUTPUT="/encrypted/encrypted_${NAME}"
        docker run --rm -v ./ssh:/src -v ./passphrase:/passphrase -v ./encrypted:/encrypted ansible-vault-keys encrypt --vault-password-file=/passphrase/pass.txt --output="$OUTPUT" $NAME
    done

    rm -rf ./passphrase
    rm -rf ./ssh
else
    echo "Install docker"
fi