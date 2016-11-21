#!/bin/sh

# Run SwiftLint
START_DATE=$(date +" %s")

echo $START_DATE

SWIFT_LINT=/usr/local/bin/swiftlint

# Run SwiftLint for given filename
run_swiftlint() {
	local filename="${1}"

	if [[ "${filename##*.}" == "swift" ]]; then
		# echo ${filename}
		${SWIFT_LINT} autocorrect --path "${filename}"
		git add -- "${filename}"

		# check lint
		${SWIFT_LINT} lint --path "${filename}"
	fi
}

if [[ -e "${SWIFT_LINT}" ]]; then
	echo "SwiftLint version: $(${SWIFT_LINT} version)"

	# Run for staged
	git diff --cached --name-only | while read filename; do run_swiftlint "${filename}"; done
else
	echo "${SWIFT_LINT} is not installed."
	echo "Plz install swiftlint use brew"
	echo "brew install swiftlint"
	exit 0
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))

echo "SwiftLint took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."