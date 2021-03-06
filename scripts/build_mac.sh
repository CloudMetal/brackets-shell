# IMPORTANT: THIS FILE WILL BE GOING AWAY SOON! USE scripts/build.sh INSTEAD! 
# YOU HAVE BEEN WARNED!

# SETUP
# - Install xcode
# - Install xcode command line tools 
# - Install DropDMG, including the dropdmg command line tool
# - Setup source directories as specified in README.md
#   (copy CEF binary, run scripts/make_symlinks.sh, etc.)
# - Set BRACKETS_SRC environment variable, pointing to the
#   brackets source code (without trailing '/')
# - Optionally, set BRACKETS_APP_NAME environment variable with the 
#   name of the application. (This should match the app name built
#   by the gyp project, and need not match the final installed build name.)
# - Optionally, set BRACKETS_SHELL_BRANCH and BRACKETS_BRANCH
#   to the branches you want to build.

# Make sure BRACKETS_SRC environment variable is set
if [ "$BRACKETS_SRC" = "" ]; then
  echo "The BRACKETS_SRC environment variable must be set to the location of the Brackets source folder. Aborting."
  exit
fi

# Default the app name to "Brackets", but override with $BRACKETS_APP_NAME if set
if [ "$BRACKETS_APP_NAME" = "" ]; then
  export BRACKETS_APP_NAME="Brackets"
fi

# Default the branches to "master"
if [ "$BRACKETS_SHELL_BRANCH" = "" ]; then
  export BRACKETS_SHELL_BRANCH="master"
fi
if [ "$BRACKETS_BRANCH" = "" ]; then
  export BRACKETS_BRANCH="master"
fi

# Pull the latest code
curDir=`pwd`
cd "$BRACKETS_SRC"
git checkout "$BRACKETS_BRANCH"
git pull origin "$BRACKETS_BRANCH"
git submodule update --init --recursive
build_num=`git log --oneline | wc -l | tr -d ' '`
brackets_sha=`git log | head -1 | sed -e 's/commit \([0-9a-f]*$\)/\1/'`
cd $curDir
git checkout "$BRACKETS_SHELL_BRANCH"
git pull origin "$BRACKETS_SHELL_BRANCH"

# Clean and build the xcode project
xcodebuild -project appshell.xcodeproj -config Release clean
xcodebuild -project appshell.xcodeproj -config Release build

# Package www files
scripts/package_www_files.sh

# Remove existing staging dir
if [ -d installer/mac/staging ]; then
  rm -rf installer/mac/staging
fi

mkdir installer/mac/staging

# Copy to installer staging folder
cp -R "xcodebuild/Release/${BRACKETS_APP_NAME}.app" installer/mac/staging/

# Set the build number, branch and sha on the staged build
cat "installer/mac/staging/${BRACKETS_APP_NAME}.app/Contents/www/package.json" \
|   sed "s:\(\"version\"[^\"]*\"[0-9.]*-\)\([0-9*]\)\(\"\):\1$build_num\3:" \
|   sed "s:\(\"branch\"[^\"]*\"\)\([^\"]*\)\(\"\):\1$BRACKETS_BRANCH\3:" \
|   sed "s:\(\"SHA\"[^\"]*\"\)\([^\"]*\)\(\"\):\1$brackets_sha\3:" \
> tmp_package_json.txt
mv tmp_package_json.txt "installer/mac/staging/${BRACKETS_APP_NAME}.app/Contents/www/package.json"

# Build the installer
cd installer/mac
./buildInstaller.sh