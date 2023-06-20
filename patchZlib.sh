#!/usr/bin/bash

set -e

prefix=$1
lib=$2
lib_wat=$TMPDIR/tmp.wasm

# wasm-strip $lib
wasm2wat $lib > $lib_wat
wat2wasm $lib_wat -r -o $lib

# wasm2wat $lib > $lib_wat
# sed -i \
#     -e "s/adler32/${prefix}_adler32/g" \
#     -e "s/af_cjk_/${prefix}_af_cjk_/g" \
#     -e "s/af_dummy_/${prefix}_af_dummy_/g" \
#     -e "s/af_glyph_/${prefix}_af_glyph_/g" \
#     -e "s/af_hint_/${prefix}_af_hint_/g" \
#     -e "s/af_warper_/${prefix}_af_warper_/g" \
#     -e "s/af_latin_/${prefix}_af_latin_/g" \
#     -e "s/af_sort_/${prefix}_af_sort_/g" \
#     -e "s/af_indic_/${prefix}_af_indic_/g" \
#     -e "s/af_property_/${prefix}_af_property_/g" \
#     -e "s/af_axis_/${prefix}_af_axis_/g" \
#     -e "s/af_iup_/${prefix}_af_iup_/g" \
#     -e "s/af_shaper_/${prefix}_af_shaper_/g" \
#     -e "s/af_autofitter_/${prefix}_af_autofitter_/g" \
#     -e "s/af_loader_/${prefix}_af_loader_/g" \
#     -e "s/af_face_/${prefix}_af_face_/g" \
#     -e "s/af_get_/${prefix}_af_get_/g" \
#     -e "s/allocator/${prefix}_allocator/g" \
#     -e "s/build_tree/${prefix}_build_tree/g" \
#     -e "s/compress/${prefix}_compress/g" \
#     -e "s/crc32/${prefix}_crc32/g" \
#     -e "s/deflate/${prefix}_deflate/g" \
#     -e "s/fill_window/${prefix}_fill_window/g" \
#     -e "s/flush_pending/${prefix}_flush_pending/g" \
#     -e "s/get_crc_table/${prefix}_get_crc_table/g" \
#     -e "s/inflate/${prefix}_inflate/g" \
#     -e "s/init_block/${prefix}_init_block/g" \
#     -e "s/length_error_abi/${prefix}_length_error_abi/g" \
#     -e "s/longest_match/${prefix}_longest_match/g" \
#     -e "s/send_tree/${prefix}_send_tree/g" \
#     -e "s/slide_hash/${prefix}_slide_hash/g" \
#     -e "s/throw_bad_array_new_length_abi/${prefix}_throw_bad_array_new_length_abi/g" \
#     -e "s/tr_align/${prefix}_tr_align/g" \
#     -e "s/tr_flush_/${prefix}_tr_flush_/g" \
#     -e "s/tr_init/${prefix}_tr_init/g" \
#     -e "s/tr_stored_/${prefix}_tr_stored_/g" \
#     -e "s/tr_tally/${prefix}_tr_tally/g" \
#     -e "s/tree_balance_after_insert/${prefix}_tree_balance_after_insert/g" \
#     -e "s/tree_remove/${prefix}_tree_remove/g" \
#     -e "s/updatewindow/${prefix}_updatewindow/g" \
#     -e "s/zError/${prefix}_zError/g" \
#     -e "s/zcalloc/${prefix}_zcalloc/g" \
#     -e "s/zcfree/${prefix}_zcfree/g" \
#     -e "s/zlib/${prefix}_zlib/g" \
#     -e "s/zlip/${prefix}_zlip/g" \
#     -e "s/out_of_range/${prefix}_out_of_range/g" \
#     -e "s/NSStructures/${prefix}_NSStructures/g" \
#     -e "s/FT_/${prefix}_FT_/g" \
#     -e "s/ft_/${prefix}_ft_/g" \
#     -e "s/raccess_/${prefix}_raccess_/g" \
#     -e "s/cubic_/${prefix}_cubic_/g" \
#     -e "s/BBox_/${prefix}_BBox_/g" \
#     -e "s/NSFonts/${prefix}_NSFonts/g" \
#     -e "s/hash_/${prefix}_hash_/g" \
#     -e "s/_face/${prefix}_face/g" \
#     -e "s/bdf_/${prefix}_bdf_/g" \
#     -e "s/BDF_/${prefix}_BDF_/g" \
#     -e "s/memory_stream_close/${prefix}_memory_stream_close/g" \
#     -e "s/ps_property/${prefix}_ps_property/g" \
#     -e "s/FTC/${prefix}_FTC/g" \
#     -e "s/ftc/${prefix}_ftc/g" \
#     $lib_wat
# wat2wasm $lib_wat -r -o $lib
