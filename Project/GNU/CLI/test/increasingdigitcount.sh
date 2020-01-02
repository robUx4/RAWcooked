#!/usr/bin/env bash

script_path="${PWD}/test"
. ${script_path}/helpers.sh

test="sequence"

pushd "${files_path}" >/dev/null 2>&1
    file=sequence1
    mkdir "${file}"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=5:size=16x16 "${file}/%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence (1)" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    rm "${file}/10.dpx"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence (1)"

    file=sequence2
    mkdir "${file}"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.200:size=16x16 -start_number 9 "${file}/%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence (2)" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    rm "${file}/10.dpx"
    rm "${file}/11.dpx"
    rm "${file}/12.dpx"
    rm "${file}/13.dpx"
    cp "${file}/9.dpx" "${file}/100.dpx"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence (2)"

    file=sequence3
    mkdir "${file}"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.400:size=16x16 -start_number 6 "${file}/%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    cp "${file}/8.dpx" "${file}/8"
    cp "${file}/8.dpx" "${file}/8-"
    cp "${file}/8.dpx" "${file}/8a"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence + 8/8-/8a files" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    run_rawcooked --conch "${file}"
    check_success "check failed on valid dpx sequence" "check succeded on valid dpx sequence + 8/8-/8a/9/9-/9a files"
    rm "${file}.mkv"
    cp "${file}/9.dpx" "${file}/9"
    cp "${file}/9.dpx" "${file}/9-"
    cp "${file}/9.dpx" "${file}/9a"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence + 8/8-/8a/9/9-/9a files" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    run_rawcooked --conch "${file}"
    check_success "check failed on valid dpx sequence" "check succeded on valid dpx sequence + 8/8-/8a/9/9-/9a files"
    rm "${file}.mkv"
    cp "${file}/10.dpx" "${file}/10"
    cp "${file}/10.dpx" "${file}/10-"
    cp "${file}/10.dpx" "${file}/10a"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence + 8/8-/8a/9/9-/9a/10/10-/10a files" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    run_rawcooked --conch "${file}"
    check_success "check failed on valid dpx sequence" "check succeded on valid dpx sequence + 8/8-/8a/9/9-/9a/10/10-/10a files"
    rm "${file}.mkv"
    rm "${file}/9.dpx"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence 9"
    rm "${file}/10.dpx"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence 9/10 + 8/8-/8a/9/9-/9a/10/10-/10a files"
    rm "${file}/10"
    rm "${file}/10-"
    rm "${file}/10a"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence 9/10 + 8/8-/8a/9/9-/9a files"
    rm "${file}/9"
    rm "${file}/9-"
    rm "${file}/9a"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence 9/10 + 8/8-/8a files"
    rm "${file}/8"
    rm "${file}/8-"
    rm "${file}/8a"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence 9/10"

    file=sequence4
    mkdir "${file}"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/%01dsuffix.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/prefix%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/prefix%01dsuffix.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence (4)" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    rm "${file}/10.dpx"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence (4)"

    file=sequence5
    mkdir "${file}"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/%01dsuffix.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/prefix%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/prefix%01dsuffix.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    run_rawcooked --check "${file}"
    check_success "check failed on valid dpx sequence (5)" "check succeded on valid dpx sequence"
    rm "${file}.mkv"
    mv "${file}/10.dpx" "${file}/10.dpx.bak"
    run_rawcooked --conch "${file}"
    check_failure "check failed due to incomplete dpx sequence" "check succeded despite incomplete dpx sequence (5)"

    file=sequence6
    mkdir "${file}"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.160:size=16x16 -start_number 8 "${file}/%01d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    ffmpeg -nostdin -f lavfi -i testsrc=duration=0.080:size=16x16 -start_number 8 "${file}/%02d.dpx" >/dev/null 2>&1|| fatal "internal" "ffmpeg command failed"
    run_rawcooked --check "${file}"
    check_failure "check failed on unsupported file names e.g. 09 and 9 in the list" "check succeded on unsupported file names e.g. 09 and 9 in the list"

    clean
popd >/dev/null 2>&1

exit ${status}