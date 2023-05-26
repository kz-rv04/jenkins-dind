#!/bin/bash

set -eu

ls -l /opt/java/openjdk/lib/security/cacerts

if [ "${PROXY:-x}" = 'x' ]; then
    # do nothing
    exit 0
fi

if [ ! -d ./InstallCert ]; then
    git clone https://github.com/escline/InstallCert.git
fi

pushd ./InstallCert
javac ./InstallCert.java

CACERTS_PATH=/opt/java/openjdk/lib/security/cacerts

TRUST_HOSTS=(${TRUST_HOST//,/ })
echo "===== PROXY: $PROXY ====="
# h=${TRUST_HOSTS[0]}
for h in "${TRUST_HOSTS[@]}"; do
    echo "===== $h ====="
    yes 1 | java InstallCert --proxy=$PROXY "${h}:443"
    keytool -exportcert -alias "${h}-1" -keystore ./jssecacerts -storepass changeit -file ./${h}.cer

    keytool -delete -alias "${h}" -keystore $CACERTS_PATH -storepass changeit -noprompt || true
    keytool -importcert -alias "${h}" -keystore $CACERTS_PATH -storepass changeit -noprompt -file ./${h}.cer -trustcacerts
done

echo -e "\n===== result ====="
for h in "${TRUST_HOSTS[@]}"; do
    keytool -v -list -alias "${h}" -keystore $CACERTS_PATH -storepass changeit | grep -E "Alias name|Entry type|Valid from"
done
echo -e "==================\n"

# cleanup
if [ -d .git ]; then
    git clean -xdf .
    git rev-parse --short HEAD >HEAD
    rm -rf .git
fi

popd >/dev/null

# set +eu

