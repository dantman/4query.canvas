SRC_DIR = src
BUILD_DIR = build

PREFIX = .
DIST_DIR = ${PREFIX}/dist

BASE_FILES = ${SRC_DIR}/core.js

MODULES = ${SRC_DIR}/intro.js\
	${BASE_FILES}\
	${SRC_DIR}/outro.js

FQC = ${DIST_DIR}/4query.canvas.js
FQC_MIN = ${DIST_DIR}/4query.canvas.min.js

FQC_VER = `cat version.txt`
VER = sed s/@VERSION/${FQC_VER}/

JAR = java -jar ${BUILD_DIR}/js.jar
MINJAR = java -jar ${BUILD_DIR}/yuicompressor-2.4.2.jar

all: canvas min
	@@echo "4query.canvas build complete."

${DIST_DIR}:
	@@mkdir -p ${DIST_DIR}

4query.canvas: canvas
canvas: ${FQC}

${FQC}: ${DIST_DIR} ${MODULES}
	@@echo "Building" ${FQC}

	@@mkdir -p ${DIST_DIR}
	@@cat ${MODULES} | \
		${VER} > ${FQC};

	@@echo ${FQC} "Built"
	@@echo

min: ${FQC_MIN}

${FQC_MIN}: ${FQC}
	@@echo "Building" ${FQC_MIN}

	@@echo " - Compressing using Minifier"
	@@${MINJAR} ${FQC} > ${FQC_MIN}

	@@echo ${FQC_MIN} "Built"
	@@echo

clean:
	@@echo "Removing Distribution directory:" ${DIST_DIR}
	@@rm -rf ${DIST_DIR}
