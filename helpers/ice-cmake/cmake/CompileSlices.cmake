# handle slice building so the projects that need it can call it
# Types:
# slice2_bin $<TARGET_FILE>:name_of_slice2_bin - compiled bin
# slice_folder_name string - name of folder (i.e. "Ice")
# gen_file_type - list of extenstions the ice files compile into
function(CompileSlices slice2_bin slice_folder_name gen_file_type)
   set(slice_path "{CMAKE_SOURCE_DIR}/slice")
   if(NOT "{PROJECT_BINARY_DIR}/include/generated/${slice_folder_name}")
      file(MAKE_DIRECTORY "{PROJECT_BINARY_DIR}/include/generated/${slice_folder_name}")
   endif()
   set(output_dir "{PROJECT_BINARY_DIR}/include/generated/${slice_folder_name}")
   
   file(GLOB ice_files ${slice_path}/${slice_folder_name})
   foreach(ice ${ice_files})
      foreach(file_type IN gen_file_types)
	     get_filename_component(ice_FILE_NAME ${ice} NAME_WE)
		 list(APPEND ice_generated_files
	        "${item_FILE_NAME}.${file_type}" 
	     )
	  endforeach()
      add_custom_command(
	     OUTPUT ${ice_generated_files}
	     COMMAND ${slice_bin} 
	     ARGS "-I${slice_path} ${ice_file}"
         WORKING_DIRECTORY ${output_dir}
	     COMMENT "Generating Ice Sources from ${ice_file_FILE_NAME}..."
      )
   endforeach()
endfunction()
