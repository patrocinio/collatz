NAME=$1
VERSION=$2
NAMESPACE=collatz
#TLS=--tls
TLS=

echo Deleting release $NAME
helm delete $NAME $TLS

echo Deploying $NAME version $VERSION
helm install $NAME ../helm/$NAME/$VERSION $TLS
