inherit externalsrc
inherit ros_distro_galactic
inherit ros_superflore_generated

DESCRIPTION = "ROS2 Package"
PRIORITY = "optional"
SECTION = "examples"
LICENSE = "CLOSED"
EXTERNALSRC = "${THISDIR}/helloworld_msgs"

ROS_CN = "demos"
ROS_BPN = "helloworld_msgs"

ROS_BUILD_DEPENDS = " \
    builtin-interfaces \
    rosidl-default-generators \
    rosidl-typesupport-c \
    rosidl-typesupport-cpp \
    sensor-msgs \
    std-msgs \
"

ROS_BUILDTOOL_DEPENDS = " \
    ament-cmake-native \
    rosidl-parser-native \
    rosidl-adapter-native \
    rosidl-generator-cpp-native \
    rosidl-generator-py-native \
    rosidl-typesupport-cpp-native \
    rosidl-typesupport-fastrtps-cpp-native \
    rosidl-typesupport-fastrtps-c-native \
    python3-numpy-native \
    python3-lark-parser-native \
"

ROS_EXPORT_DEPENDS = ""

ROS_BUILDTOOL_EXPORT_DEPENDS = ""

ROS_EXEC_DEPENDS = " \
    builtin-interfaces \
    rosidl-default-runtime \
"

# Currently informational only -- see http://www.ros.org/reps/rep-0149.html#dependency-tags.
ROS_TEST_DEPENDS = ""

DEPENDS = "${ROS_BUILD_DEPENDS} ${ROS_BUILDTOOL_DEPENDS}"
# Bitbake doesn't support the "export" concept, so build them as if we needed them to build this package (even though we actually
# don't) so that they're guaranteed to have been staged should this package appear in another's DEPENDS.
DEPENDS += "${ROS_EXPORT_DEPENDS} ${ROS_BUILDTOOL_EXPORT_DEPENDS}"

RDEPENDS:${PN} += "${ROS_EXEC_DEPENDS}"

ROS_BUILD_TYPE = "ament_cmake"

inherit ros_${ROS_BUILD_TYPE}
