# CompileSlice - script slice compile with cmake similar to IceBuilder
# 
# Params:
# slice2_bin - name_of_slice2_bin (compiled bin)
# slice2bin_params - parameters passed for specific slice2_bin use cases
# slice_include_paths - include dir(s) needed for -I parameter
# ice_files - files to be compiled (<filename>.ice)
# output_dir - specify the output dir for created sources
function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
    add_custom_command(OUTPUT ${output_file}
        COMMAND ${slice2_bin} 
        ARGS ${slice_include_paths} ${ice_file} ${slice2bin_params}
        WORKING_DIRECTORY ${output_dir}
        MAIN_DEPENDENCY ${slice2_bin}
        DEPENDS ${ice_file}
        COMMENT "Compiling sources for ${ice_file}..."
    )
endfunction()
