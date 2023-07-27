#!/usr/bin/env sh

# Rename TRUE to true
sed -i -e 's/TRUE/true/' UnicodeConverter/UnicodeConverter.cpp

# Remove icu from dependencies, emscripten has a buildin libicu
sed -i -e 's,$$PWD/$$CORE_BUILDS_PLATFORM_PREFIX/build/libicuuc.so.$$ICU_MAJOR_VER,,' \
    Common/3dParty/icu/icu.pri
sed -i -e 's,$$PWD/$$CORE_BUILDS_PLATFORM_PREFIX/build/libicudata.so.$$ICU_MAJOR_VER,,' \
    Common/3dParty/icu/icu.pri

## Fix #include which has to many ../
sed -i -e 's,#include "../../../../../../DesktopEditor/common/Types.h,#include "../../../../DesktopEditor/common/Types.h",' \
    MsBinaryFile/Common/Vml/PPTShape/BinaryReader.h

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

# Remove c-files with a main() from the build to avoid duplicate symbols
sed -i -e 's,$$PWD/src/zlib-1.2.11/contrib/minizip/miniunz.c,,' \
    OfficeUtils/OfficeUtils.pri
sed -i -e 's,$$PWD/src/zlib-1.2.11/contrib/minizip/minizip.c,,' \
    OfficeUtils/OfficeUtils.pri

# Do not link CryptoPPLib when building PdfFile. It is linked later.
# This prevents duplicate symbol errors.
sed -i -e 's,-lCryptoPPLib,,' \
    PdfFile/PdfFile.pro

# Prevent duplicate symbol error by renaming one of these functions.
sed -i -e 's,GenerateUUID,Fb2GenerateUUID,' \
    Fb2File/Fb2File.cpp
sed -i -e 's,replace_all,Fb2replace_all,' \
    Fb2File/Fb2File.cpp

# Use __ANDROID__ code to fix byte allignment issues for __WASM__
sed -i -e 's,__ANDROID__,__WASM__,' \
    OOXML/Binary/Presentation/BinaryFileReaderWriter.cpp

# sed -i -e '885 i std::cout << "XXX File" << (size_t)pShort;' \
#     DesktopEditor/common/File.cpp
# sed -i -e '1 i #include <iostream>' \
#     DesktopEditor/common/File.cpp

# sed -i -e '2926 i printf("XXX SAX 2 %d\\n", (size_t)&xmlDefaultSAXHandler);' \
#     DesktopEditor/xml/libxml2/SAX2.c

# sed -i -e '2862 i printf("XXX SAX %d %d %d %d\\n", sizeof(xmlSAXHandler), sizeof(xmlSAX2StartElement), sizeof(hdlr->startElement), version);' \
#     DesktopEditor/xml/libxml2/SAX2.c
