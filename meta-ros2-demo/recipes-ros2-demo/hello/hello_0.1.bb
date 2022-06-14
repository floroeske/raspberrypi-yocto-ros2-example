DESCRIPTION = "A friendly program that prints Hello World!"
PRIORITY = "optional"
SECTION = "examples"
LICENSE = "CLOSED"
SRC_URI = "file://hello.c"
S = "${WORKDIR}"

do_compile() {
             ${CC} ${CFLAGS} ${LDFLAGS} hello.c -o hello
}

do_install() {
             install -d ${D}${bindir}
             install -m 0755 hello ${D}${bindir}
}