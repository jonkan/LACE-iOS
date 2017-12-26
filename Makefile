BUILDTYPE ?= Release
DERIVED_DATA=build
OUTPUT=build/framework
BUILD_PRODUCTS=${DERIVED_DATA}/Build/Products

.PHONY: clean
clean:
	rm -rf ${DERIVED_DATA}

.PHONY: iframework
iframework:
	git submodule update --init
	set -o pipefail && xcodebuild -derivedDataPath ${DERIVED_DATA} -scheme 'Eigen' -configuration ${BUILDTYPE} -arch armv7 -arch armv7s -arch arm64 -sdk iphoneos | xcpretty
	set -o pipefail && xcodebuild -derivedDataPath ${DERIVED_DATA} -scheme 'Eigen' -configuration ${BUILDTYPE} -sdk iphonesimulator | xcpretty
	set -o pipefail && xcodebuild -derivedDataPath ${DERIVED_DATA} -scheme 'LACE' -configuration ${BUILDTYPE} -arch armv7 -arch armv7s -arch arm64 -sdk iphoneos | xcpretty
	set -o pipefail && xcodebuild -derivedDataPath ${DERIVED_DATA} -scheme 'LACE' -configuration ${BUILDTYPE} -sdk iphonesimulator | xcpretty
	rm -rf ${OUTPUT}
	cp -R ${BUILD_PRODUCTS}/${BUILDTYPE}-iphonesimulator/Eigen.framework ${OUTPUT}
	cp -R ${BUILD_PRODUCTS}/${BUILDTYPE}-iphoneos/Eigen.framework ${OUTPUT}
	lipo -create -output ${OUTPUT}/Eigen.framework/Eigen ${BUILD_PRODUCTS}/${BUILDTYPE}-iphoneos/Eigen.framework/Eigen ${BUILD_PRODUCTS}/${BUILDTYPE}-iphonesimulator/Eigen.framework/Eigen

	cp -R ${BUILD_PRODUCTS}/${BUILDTYPE}-iphonesimulator/LACE.framework ${OUTPUT}
	cp -R ${BUILD_PRODUCTS}/${BUILDTYPE}-iphoneos/LACE.framework ${OUTPUT}
	lipo -create -output ${OUTPUT}/LACE.framework/LACE ${BUILD_PRODUCTS}/${BUILDTYPE}-iphoneos/LACE.framework/LACE ${BUILD_PRODUCTS}/${BUILDTYPE}-iphonesimulator/LACE.framework/LACE
