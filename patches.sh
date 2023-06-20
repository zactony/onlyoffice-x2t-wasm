#!/usr/bin/env sh

# Rename TRUE to true
sed -i -e 's/TRUE/true/' UnicodeConverter/UnicodeConverter.cpp

# Remove icu from dependencies, emscripten has a buildin libicu
sed -i -e 's,$$PWD/$$CORE_BUILDS_PLATFORM_PREFIX/build/libicuuc.so.$$ICU_MAJOR_VER,,' \
    Common/3dParty/icu/icu.pri
sed -i -e 's,$$PWD/$$CORE_BUILDS_PLATFORM_PREFIX/build/libicudata.so.$$ICU_MAJOR_VER,,' \
    Common/3dParty/icu/icu.pri

## Remove due to duplicate main() symbols
#sed -i -e 's,$$PWD/src/zlib-1.2.11/contrib/minizip/miniunz.c,,' \
#    OfficeUtils/OfficeUtils.pri
#sed -i -e 's,$$PWD/src/zlib-1.2.11/contrib/minizip/minizip.c,,' \
#    OfficeUtils/OfficeUtils.pri
#
## Add missing include to gzip TODO can I use DEFINE instead?
#sed -i -e '1 i #include <unistd.h>' \
#    OfficeUtils/src/zlib-1.2.11/gzguts.h
#
## Fix #include which has to many ../
sed -i -e 's,#include "../../../../../../DesktopEditor/common/Types.h,#include "../../../../DesktopEditor/common/Types.h",' \
    MsBinaryFile/Common/Vml/PPTShape/BinaryReader.h
#
## Add missing include to svg TODO can I use DEFINE instead?
#sed -i -e '1 i #include "../../Common/MetaFile.h"' \
#    DesktopEditor/raster/Metafile/Wmf/WmfInterpretator/CInterpretatorSvgBase.cpp

# --disable-new-dtags does not exist in emscripten linker
sed -i -e 's/-Wl,--disable-new-dtags//' \
    UnicodeConverter/UnicodeConverter.pro
sed -i -e 's/-Wl,--disable-new-dtags//' \
    Common/base.pri

# Use globally installed gumbo and katana parsers
sed -i -e 's,#include "gumbo-parser/src/gumbo.h",#include "/gumbo-parser/src/gumbo.h",' \
    Common/3dParty/html/htmltoxhtml.h
sed -i -e 's,#include "../../katana-parser/src/katana.h",#include "/katana-parser/src/katana.h",' \
    Common/3dParty/html/css/src/CCssCalculator_Private.h
sed -i -e 's,#include "../../katana-parser/src/selector.h",#include "/katana-parser/src/selector.h",' \
    Common/3dParty/html/css/src/CCssCalculator_Private.cpp

# Do not link boost_regex. It does not need to be linked.
sed -i -e 's,-lboost_regex,,' \
    Common/3dParty/boost/boost.pri

# Remove network dependencies
# sed -i -e 's/, kernel_network//' \
#     PdfFile/PdfFile.pro
# sed -i -e 's/, kernel_network//' \
#     HtmlFile2/HtmlFile2.pro
# sed -i -e 's/, kernel_network//' \
#     DesktopEditor/doctrenderer/doctrenderer.pro
# sed -i -e 's/, kernel_network//' \
#     X2tConverter/build/Qt/X2tConverter.pri

# Link zlib into Common instead of including it in the build
# sed -i -e 's/build_all_zlib//' \
#     Common/kernel.pro
# sed -i -e 's/build_zlib_as_sources//' \
#     Common/kernel.pro

# Remove c-files with a main() from the build to avoid duplicate symbols
sed -i -e 's,$$PWD/src/zlib-1.2.11/contrib/minizip/miniunz.c,,' \
    OfficeUtils/OfficeUtils.pri
sed -i -e 's,$$PWD/src/zlib-1.2.11/contrib/minizip/minizip.c,,' \
    OfficeUtils/OfficeUtils.pri

# Do not include freetype in the build, but link it later
# sed -i -e 's,$$FREETYPE_PATH/[^ ]*\.c,,' \
#     DesktopEditor/graphics/pro/freetype.pri

# Do not link CryptoPPLib when building PdfFile. It is linked later.
# This prevents duplicate symbol errors.
sed -i -e 's,-lCryptoPPLib,,' \
    PdfFile/PdfFile.pro

# Prevent duplicate symbol error by renaming one of these functions.
sed -i -e 's,GenerateUUID,Fb2GenerateUUID,' \
    Fb2File/Fb2File.cpp
sed -i -e 's,replace_all,Fb2replace_all,' \
    Fb2File/Fb2File.cpp
