#!/usr/bin/env bash

name=foo
i=4
curdir=$(pwd)
blade init -v 7.$i lworkspace$i 
cd lworkspace$i/modules && blade create -t service-builder -v 7.$i -p com.liferay.example $name 
sed -i 's/^dependencies {$/dependencies {\n\tserviceBuilder group: "com.liferay", name: "com.liferay.portal.tools.service.builder", version: "1.0.445"\n/' $curdir/lworkspace$i/modules/$name/$name-service/build.gradle
sed -i 's/release.portal.api/release.dxp.api/' $curdir/lworkspace$i/modules/$name/$name-service/build.gradle
sed -i 's/release.portal.api/release.dxp.api/' $curdir/lworkspace$i/modules/$name/$name-api/build.gradle
sed -i "s/^liferay.workspace.product=portal/liferay.workspace.product=dxp/" $curdir/lworkspace$i/gradle.properties
#cd $curdir/lworkspace$i/modules/$name/$name-service && ../../../gradlew buildService && cd .. && ../../gradlew build 
