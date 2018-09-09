NAME=$1
VERSION=$2
NAMESPACE=collatz
TLS=--tls
#TLS=

echo Deleting release $NAME
helm delete --purge $NAME $TLS

echo Deploying $NAME version $VERSION
helm install -n $NAME ../helm/$NAME/$VERSION $TLS
