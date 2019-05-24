# handle slice building so the projects that need it can call it
# Types:
# slice2_bin name_of_slice2_bin - compiled bin
# slice_path string - root/slice
# slice_folder_name string - name of folder (i.e. "Ice")
# slice_target - lib or exe this compile depends on
# output_dir string - where compiled files will be output to
function(CompileSlices slice2_bin slice_path slice_folder_name slice_target output_dir)
   file(GLOB ice_files ${slice_path}/${slice_folder_name}/*.ice)
   foreach(ice ${ice_files})
      get_filename_component(ice_FILE_NAME ${ice} NAME_WE)
      add_custom_command(TARGET ${slice_target}
         COMMAND ${slice2_bin} -I${slice_path} ${ice}
         WORKING_DIRECTORY ${output_dir}
         DEPENDS "${ice_FILE_NAME}.ice"
         PRE_BUILD
      )
   endforeach()
endfunction()
