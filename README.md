This project is a prototype of managment toolchains designed to simplify the process of compiling accress architectural platforms.



* The directory framework currently in use:

```shell
.
├── bin/
├── environments/
├── include/
├── libexec/
├── packages
├── README.md
├── toolchain-aarch64_cortex-a53_gcc-5.2.0_musl-1.1.16/
├── toolchain-aarch64-unknown-linux-gnu/
├── toolchain-aarch64-unknown-linux-gnu-old/
├── toolchain-aarch64-unknown-linux-musl/
├── toolchain-arm-buildroot_gcc-v4.9.3_glibc-v2.22/
├── toolchain-arm_cortex-a7_gcc-11.3.0_musl_eabi/
├── toolchain-arm_cortex-a7_gcc-4.8-linaro_uClibc-0.9.33.2_eabi/
├── toolchain-arm_cortex-a7_gcc-8.4.0_glibc_eabi/
├── toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi/
├── toolchain-mipsel_1004kc+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/
├── toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/
├── toolchain-mips_r2_gcc-4.6-linaro_uClibc-0.9.33.2/
├── toolchain-pc-x86_64_gcc-v12.2_glibc-v2.37/
├── toolchain_x86_64_gcc-v5.4.0_musl-v1.1.16/
├── toolchain-x86_64-unknown-linux/
├── toolchain-x86_64-unknown-linux_gcc-v0.0_glibc-v0.0/
└── toolchain-x86_64-unknown-linux-gnu/
```

This tool are used in a similar way to python's virtual environment.

* Activation tool

```shell
source bin/active
```

* Displays the currently supported toolchains.

```shell
toolchains list
```


* Global environment variable：

```shell
TOOLCHIANS='/opt/toolchains'
TOOLCHAINS_INCLUDE=${TOOLCHAINS}/include
TOOLCHAINS_LIB=${TOOLCHAINS}/lib
TOOLCHAINS_LIBEXEC=${TOOLCHAINS}/libexec
TOOLCHAINS_BIN=${TOOLCHAINS}/bin
TOOLCHAINS_ETC=${TOOLCHAINS}/etc

TOOLCHAINS_ENV=${TOOLCHAINS}/enviroments
TOOLCHAINS_HOME=${TOOLCHAINS}/toolchains
```


