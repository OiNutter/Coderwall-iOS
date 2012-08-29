#!/bin/sh


set -e


BUILD_NUMBER=$1

die () {
    echo >&2 "$@"
    exit
}
[ "$#" -ge 1  ] || die "$0 BUILD_NUMBER"


PROJECT_ROOT="`pwd`"
SYMROOT="$PROJECT_ROOT/build"
DIST_DIR="$PROJECT_ROOT/dist"


echo "### CREATE DIST DIRECTORY"
echo "rm -rf $SYMROOT"
rm -rf "$SYMROOT"
echo "rm -rf $DIST_DIR"
rm -rf "$DIST_DIR"
echo "mkdir -p $DIST_DIR"
mkdir -p "$DIST_DIR"
ls -laF


build_and_package()
{
    CONFIGURATION=$1
    PACKAGENAME=`echo $CONFIGURATION | sed 's%/%-%g' | tr '[A-Z]' '[a-z]'`
    BUILD_DIR="$SYMROOT/$PACKAGENAME-iphoneos"

    if [ "$MODIFYCONFIG" = "YES" ]; then
        replace_infoplist $CONFIGURATION
    fi

    echo "### EXECUTING BUILD COMMAND : CONFIGURATION[$CONFIGURATION]"
    echo "xcodebuild -workspace Coderwall.xcworkspace -scheme Coderwall -configuration $CONFIGURATION -sdk iphoneos CONFIGURATION_BUILD_DIR=\"$BUILD_DIR\" SYMROOT=$SYMROOT clean build"
    xcodebuild -workspace Coderwall.xcworkspace -scheme Coderwall -configuration "$CONFIGURATION" -sdk iphoneos CONFIGURATION_BUILD_DIR="$BUILD_DIR" SYMROOT="$SYMROOT" clean build

    BUILD_RESULT=$?

    ## HANDLE BUILD FAILURE
    if [ "$BUILD_RESULT" -ne "0" ]; then
        echo "### FAILED TO BUILD APP : CONFIGURATION[$CONFIGURATION] WITH EXIT CODE[$BUILD_RESULT]"
        exit $?
    fi

    echo ""
    echo "### START PACKAGING APP : CONFIGURATION[$CONFIGURATION]"
    echo ""

    # PACKAGE
    cd "$BUILD_DIR"
    zip -9 -y -r "$DIST_DIR/Coderwall_$PACKAGENAME"_"b$BUILD_NUMBER.zip" "Coderwall.app"

    if [ -f "$DIST_DIR/Coderwall_$PACKAGENAME"_"b$BUILD_NUMBER.zip" ]; then
        echo ""
        echo "### FINISHED BUILD APP : CONFIGURATION[$CONFIGURATION]"
        echo "### " `date`
        echo ""
    else
        echo "PACKAGING FAILED : CONFIGURATION[$CONFIGURATION]"
        exit 1
    fi

    cd "$PROJECT_ROOT"
}


kill_simulator()
{
    if [[ $(ps axo pid,command | grep "[i]Phone Simulator") ]]; then
        killall "iPhone Simulator"
    fi
}


run_integration_tests()
{
    echo "### RUN INTEGRATION TESTS"
    BUILD_DIR="$SYMROOT/Debug-iphonesimulator"
    xcodebuild -workspace Coderwall.xcworkspace -scheme "Integration Tests" -configuration Debug -sdk iphonesimulator -xcconfig="Pods/Pods-integration.xcconfig" CONFIGURATION_BUILD_DIR="$BUILD_DIR" SYMROOT="$SYMROOT" clean build

    kill_simulator

    OUTPUT_FILE="$DIST_DIR/kif_results_$BUILD_NUMBER.txt"
    ios-sim launch "$BUILD_DIR/Coderwall (Integration Tests).app" --stdout "$OUTPUT_FILE" --stderr "$OUTPUT_FILE"
    cat "$OUTPUT_FILE"
    grep -q "TESTING FINISHED: 0 failures" "$OUTPUT_FILE"
}


run_unit_tests()
{
    OUTPUT_FILE="$DIST_DIR/kiwi_results_$BUILD_NUMBER.txt"

    echo "### RUN UNIT TESTS"
    kill_simulator
    xcodebuild -workspace Coderwall.xcworkspace/ -scheme "Unit Tests" -sdk iphonesimulator TEST_AFTER_BUILD=YES clean build > "$OUTPUT_FILE"
    cat "$OUTPUT_FILE"
    exit `grep -c "FAILED" "$OUTPUT_FILE"`
}


build_and_package Debug
build_and_package Release
run_integration_tests
run_unit_tests
