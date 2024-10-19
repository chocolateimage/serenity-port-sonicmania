#!/usr/bin/env -S bash ../.port_include.sh
port='SonicMania'
version='f92e8e33120cc8fe6cfe21a48e31b089a6856fdf'
useconfigure='true'
workdir="Sonic-Mania-Decompilation-${version}"
files=(
    "https://github.com/RSDKModding/Sonic-Mania-Decompilation/archive/${version}.zip#48b2285adb2f62da9a884e0112a08256612410b34188a8bfe72dddca744778d0"
    "https://github.com/RSDKModding/RSDKv5-Decompilation/archive/1220d9140f693c8001789d13248d635b67adf262.zip#85bf541e5e83aef69de8efc16dd43ebb32a5d18f9c4841fed3e2c946f1d028e6"
    "https://github.com/nothings/stb/archive/af1a5bc352164740c1cc1354942b1c6b72eacb8a.zip#e3d0edbecd356506d3d69b87419de2f9d180a98099134c6343177885f6c2cbef"
    "https://github.com/leethomason/tinyxml2/archive/e45d9d16d430a3f5d3eee9fe40d5e194e1e5e63a.zip#25ebc3c3028e52ca01e6795381edd271bcc54b933b657ad88464832a67f42a34"
)
configopts=(
    "-DGAME_STATIC=on"
    "-DRETRO_SUBSYSTEM=SDL2"
    "-DPLATFORM=Linux"
)
depends=(
    "SDL2"
    "libtheora"
)
launcher_name='Sonic Mania'
launcher_category='&Games'
launcher_command=/usr/local/bin/SonicMania
icon_file=dependencies/RSDKv5/RSDKv5/RSDKv5.ico

post_fetch() {
    if [ -d "RSDKv5-Decompilation-1220d9140f693c8001789d13248d635b67adf262" ]; then
        run rm -d "dependencies/RSDKv5"
        run mv "../RSDKv5-Decompilation-1220d9140f693c8001789d13248d635b67adf262" "dependencies/RSDKv5"
        run rm -d "dependencies/RSDKv5/dependencies/all/stb_vorbis"
        run rm -d "dependencies/RSDKv5/dependencies/all/tinyxml2"
        run mv "../stb-af1a5bc352164740c1cc1354942b1c6b72eacb8a" "dependencies/RSDKv5/dependencies/all/stb_vorbis"
        run mv "../tinyxml2-e45d9d16d430a3f5d3eee9fe40d5e194e1e5e63a" "dependencies/RSDKv5/dependencies/all/tinyxml2"
        run sed -i 's/.$//' dependencies/RSDKv5/dependencies/all/tinyxml2/tinyxml2.cpp
    fi
}

configure() {
    run cmake -B build "${configopts[@]}"
}

build() {
    run cmake --build build --config release
}

install() {
    cp "${workdir}/build/dependencies/RSDKv5/RSDKv5U" "${SERENITY_INSTALL_ROOT}/usr/local/bin/SonicMania"
}

post_install() {
    echo
    echo "==== Post installation instructions ===="
    echo "The file 'Data.rsdk' must be placed in the"
    echo "directory ~/.config/sonicmania inside SerenityOS."
    echo "It can be found within the Steam version of"
    echo "Sonic Mania."
    echo
}
