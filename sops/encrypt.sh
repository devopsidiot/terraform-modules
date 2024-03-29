#!/bin/bash
for i in *.decrypted.yaml; do
    [[ $i = "*.decrypted.yaml" ]] && break
    DECRYPTED_FILE=$i
    ENCRYPTED_FILE=$(echo $DECRYPTED_FILE | cut -d'.' -f 1).sops.yaml
    sops --encrypt $DECRYPTED_FILE > $ENCRYPTED_FILE
done
