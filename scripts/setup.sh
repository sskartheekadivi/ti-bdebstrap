#!/bin/bash

function setup_log_file() {
	# create the log directory if it doesn't already exist
	LOG_DIR="${topdir}/logs"
	mkdir -p "${LOG_DIR}"

	# we want to create a different log file for each run. So name these files
	# with timestamps.
	export LOG_FILE="$LOG_DIR/run_$(date +"%Y-%m-%d_%H:%M:%S").log"
	touch "${LOG_FILE}"
}

function setup_build_tools() {
    echo "> Arm Toolchain: checking .."
    if [ ! -d "${topdir}/tools/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf/bin" ]; then
        mkdir -p ${topdir}/tools/
        cd ${topdir}/tools/

        echo "> Arm Toolchain: not found. Downloading .." 
        wget https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz
        tar -Jxf gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz
        rm gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz
        echo "> Arm Toolchain: downloaded .." 
    else
        echo "> Arm Toolchain: available"
    fi
    export PATH=${topdir}/tools/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf/bin:$PATH

    echo "> Aarch64 Toolchain: checking .."
    if [ ! -d "${topdir}/tools/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin" ]; then
        mkdir -p ${topdir}/tools/
        cd ${topdir}/tools/

        echo "> Aarch64 Toolchain: not found. downloading .." 
        wget https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
        tar -Jxf gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
        rm gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
        echo "> Aarch64 Toolchain: downloaded .." 
    else
        echo "> Aarch64 Toolchain: available"
    fi
    export PATH=${topdir}/tools/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin:$PATH
}

