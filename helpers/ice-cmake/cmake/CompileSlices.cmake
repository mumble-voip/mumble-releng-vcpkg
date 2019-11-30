# handle slice building so the projects that need it can call it
# Types:
# slice2_bin - name_of_slice2_bin (compiled bin)
# slice_path - root/slice
# slice_dir - name of folder (i.e. "Ice")
# slice_outputs - source filename and types for the specific language
# include_dir - needed to name generated header guards
# output_dir - specify the output dir for created sources
function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    add_custom_command(TARGET ${slice_target}
        COMMAND ${slice2_bin} -I${slice_path} ${ice_file} --include-dir ${include_dir}
        WORKING_DIRECTORY ${output_dir}
        DEPENDS ${ice_file} ${slice2_bin}
        PRE_BUILD
        COMMENT "Generating sources for ${ice_file}..."
    )
endfunction()
