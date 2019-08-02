# handle slice building so the projects that need it can call it
# Types:
# slice2_bin name_of_slice2_bin - compiled bin
# slice_path - root/slice
# slice_dir - name of folder (i.e. "Ice")
# slice_target - lib or exe this compile depends on
# output_dir - where compiled files will be output to
function(CompileSlices slice2_bin slice_path slice_dir slice_target output_dir lang_std)
   file(GLOB ice_files ${slice_path}/${slice_dir}/*.ice)
   foreach(ice ${ice_files})
         get_filename_component(ice_FILE_NAME ${ice} NAME_WE)
         add_custom_command(TARGET ${slice_target}
            COMMAND ${slice2_bin} -I${slice_path} ${ice} ${lang_std}
            WORKING_DIRECTORY ${output_dir}
            PRE_BUILD
         )
   endforeach()
endfunction()
