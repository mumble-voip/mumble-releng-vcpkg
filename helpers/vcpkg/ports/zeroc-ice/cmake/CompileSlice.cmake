# CompileSlice - script slice compile with cmake similar to IceBuilder
# 
# Params:
# slice2_bin - name_of_slice2_bin (compiled bin)
# slice2bin_params - parameters passed for specific slice2_bin use cases
# slice_include_paths - include dir(s) needed for -I parameter
# ice_files - files to be compiled (<filename>.ice)
# output_dir - generated source output path
# output_file - generated source output file name

function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
    add_custom_command(OUTPUT ${output_file}
        COMMAND ${slice2_bin} 
        ARGS ${slice_include_paths} ${ice_file} ${slice2bin_params}
        BYPRODUCTS ${output_file}
        WORKING_DIRECTORY ${output_dir}
        MAIN_DEPENDENCY ${ice_file}
        DEPENDS ${slice2_bin}
        COMMENT "Generating sources for ${ice_file}..."
    )
endfunction()
