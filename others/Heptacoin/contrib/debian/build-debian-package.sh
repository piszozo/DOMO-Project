#!/bin/bash
## Usage:
##  ./contrib/debian/build-debian-package.sh

set -e
set -x

BUILD_PATH="/tmp/build"
PACKAGE_NAME="heptacoin"
SRC_PATH=`pwd`
SRC_DEB=$SRC_PATH/contrib/debian
SRC_DOC=$SRC_PATH/doc

umask 022

if [ ! -d $BUILD_PATH ]; then
    mkdir $BUILD_PATH
fi

PACKAGE_VERSION=$($SRC_PATH/src/heptacoind --version | grep version | cut -d' ' -f5 | tr -d v)
DEBVERSION=$(echo $PACKAGE_VERSION | sed 's/-beta/~beta/' | sed 's/-rc/~rc/' | sed 's/-/+/')
BUILD_DIR="$BUILD_PATH/$PACKAGE_NAME-$PACKAGE_VERSION-amd64"

if [ -d $BUILD_DIR ]; then
    rm -R $BUILD_DIR
fi

DEB_BIN=$BUILD_DIR/usr/bin
DEB_CMP=$BUILD_DIR/usr/share/bash-completion/completions
DEB_DOC=$BUILD_DIR/usr/share/doc/$PACKAGE_NAME
DEB_MAN=$BUILD_DIR/usr/share/man/man1
mkdir -p $BUILD_DIR/DEBIAN $DEB_CMP $DEB_BIN $DEB_DOC $DEB_MAN
chmod 0755 -R $BUILD_DIR/*

# Package maintainer scripts (currently empty)
#cp $SRC_DEB/postinst $BUILD_DIR/DEBIAN
#cp $SRC_DEB/postrm $BUILD_DIR/DEBIAN
#cp $SRC_DEB/preinst $BUILD_DIR/DEBIAN
#cp $SRC_DEB/prerm $BUILD_DIR/DEBIAN
# Copy binaries
cp $SRC_PATH/src/heptacoind $DEB_BIN
cp $SRC_PATH/src/heptacoin-cli $DEB_BIN
cp $SRC_PATH/src/heptacoin-tx $DEB_BIN
cp $SRC_PATH/src/qt/heptacoin-qt $DEB_BIN
# Copy docs
cp $SRC_PATH/doc/release-notes/release-notes-0.13.2.md $DEB_DOC/changelog
cp $SRC_DEB/changelog $DEB_DOC/changelog.Debian
cp $SRC_DEB/copyright $DEB_DOC
cp -r $SRC_DEB/examples $DEB_DOC
# Copy manpages
cp $SRC_DEB/manpages/heptacoind.1 $DEB_MAN
cp $SRC_DEB/manpages/heptacoin-cli.1 $DEB_MAN
cp $SRC_DEB/manpages/heptacoin-tx.1 $DEB_MAN
cp $SRC_DEB/manpages/heptacoin-qt.1 $DEB_MAN
# Copy bash completion files
cp $SRC_PATH/contrib/heptacoind.bash-completion $DEB_CMP/heptacoind
cp $SRC_PATH/contrib/heptacoin-cli.bash-completion $DEB_CMP/heptacoin-cli
cp $SRC_PATH/contrib/heptacoin-tx.bash-completion $DEB_CMP/heptacoin-tx
# Gzip files
gzip --best -n $DEB_DOC/changelog
gzip --best -n $DEB_DOC/changelog.Debian
gzip --best -n $DEB_MAN/heptacoind.1
gzip --best -n $DEB_MAN/heptacoin-cli.1
gzip --best -n $DEB_MAN/heptacoin-tx.1
gzip --best -n $DEB_MAN/heptacoin-qt.1

cd $SRC_PATH/contrib

# Create the control file
strip $DEB_BIN/heptacoind $DEB_BIN/heptacoin-cli $DEB_BIN/heptacoin-tx $DEB_BIN/heptacoin-qt
dpkg-shlibdeps $DEB_BIN/heptacoind $DEB_BIN/heptacoin-cli $DEB_BIN/heptacoin-tx $DEB_BIN/heptacoin-qt
dpkg-gencontrol -P$BUILD_DIR -v$DEBVERSION

# Create the Debian package
fakeroot dpkg-deb --build $BUILD_DIR
cp $BUILD_PATH/$PACKAGE_NAME-$PACKAGE_VERSION-amd64.deb $SRC_PATH
# Analyze with Lintian, reporting bugs and policy violations
lintian -i $SRC_PATH/$PACKAGE_NAME-$PACKAGE_VERSION-amd64.deb
exit 0
