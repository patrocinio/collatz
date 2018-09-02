COMPONENT=$1
VERSION=$2

echo Building component $COMPONENT at version $VERSION
cd ../src

IMAGE=patrocinio/robinhood-$COMPONENT:$VERSION
docker build --build-arg version=$VERSION \
	--build-arg component=$COMPONENT -t $IMAGE -f $COMPONENT/Dockerfile .

