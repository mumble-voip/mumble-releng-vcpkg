# CompileSlice - script slice compile with cmake similar to IceBuilder
# 
# Params:
# slice2bin - name_of_slice2_bin (compiled bin)
# slice2bin_params - pass paramaters to slice2bin as string
#                    See params list here: https://doc.zeroc.com/ice/3.7/the-slice-language/using-the-slice-compilers
# slice_target - cmake target (lib or bin) that is compiling the slice
# output_dir - specify the output dir for created sources
function(CompileSlice slice2bin slice2bin_params slice_target output_dir)
    add_custom_command(TARGET ${slice_target}
        COMMAND ${slice2_bin} ${slice2bin_params}
        WORKING_DIRECTORY ${output_dir}
        DEPENDS ${slice2_bin}
        PRE_BUILD
    )
endfunction()
