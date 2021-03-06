#!/bin/sh

projectname=`sed -n 's,.*name="app_name">\(.*\)<.*,\1,p' app/res/values/strings.xml`

echo "Setting up build for $projectname"
echo ""

for f in `find external/ -name project.properties`; do
projectdir=`dirname $f`
    echo "Updating ant setup in $projectdir:"
    android update lib-project --path $projectdir
done

if [ -f app/libs/android-support-v4.jar ]; then
    for f in `find external/ -name android-support-v4.jar`; do
    libsdir=`dirname $f`
        echo "Updating support library in $libsdir:"
        cp -f app/libs/android-support-v4.jar $libsdir
    done
fi

if [ -f app/libs/sqlcipher.jar ]; then
    for f in `find external/ -name sqlcipher.jar`; do
    libsdir=`dirname $f`
        echo "Updating support library in $libsdir:"
        cp -f app/libs/sqlcipher.jar $libsdir
    done
fi

android update project --path app/ --subprojects --name "$projectname"
