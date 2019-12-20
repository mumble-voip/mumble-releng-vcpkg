# CompileSlice - script slice compile with cmake similar to IceBuilder
# 
# Params:
# slice2_bin - name_of_slice2_bin (compiled bin)
# slice_include_paths - include dir(s) needed for -I parameter
# ice_file - file to be compiled (<filename>.ice)
# slice_target - cmake target (lib or bin) that is compiling the slice
# output_dir - specify the output dir for created sources
function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file slice_target output_dir)
    add_custom_command(TARGET ${slice_target}
        COMMAND ${slice2_bin} 
        ARGS ${slice_include_paths} ${ice_file} ${slice2bin_params}
        WORKING_DIRECTORY ${output_dir}
        MAIN_DEPENDENCY ${ice_file}
        PRE_BUILD
    )
endfunction()
