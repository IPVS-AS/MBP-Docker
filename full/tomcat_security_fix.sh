#!/bin/bash
sudo find /usr/lib/jvm -mount -name 'java.security' | while read line; do
    echo "Modifying '$line'"
    sudo sed -i 's|securerandom\.source=file\:/dev/random|securerandom.source=file:/dev/./urandom|g' "$line"
    sudo sed -i 's|securerandom\.source=file\:/dev/urandom|securerandom.source=file:/dev/./urandom|g' "$line"
done
