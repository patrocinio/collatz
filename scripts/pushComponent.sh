COMPONENT=$1
VERSION=$2

IMAGE=patrocinio/collatz-$COMPONENT:$VERSION

echo Pushing component $COMPONENT as latest version
LATEST=patrocinio/collatz-$COMPONENT:latest
docker tag $IMAGE $LATEST
docker push $LATEST

echo Pushing component $COMPONENT as version $VERSION
docker tag $IMAGE $IMAGE
docker push $IMAGE
