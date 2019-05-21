# handle slice building so the projects that need it can call it
function(CompileSlices slice_bin slice_path ice_file output_dir gen_file_type)
   get_filename_component(ice_file_FILE_NAME ${ice_file} NAME_WE)
   add_custom_command(
	  OUTPUT ${gen_file_type}
	  COMMAND ${slice_bin} 
	  ARGS "-I${slice_path} ${ice_file}"
      WORKING_DIRECTORY ${output_dir}
	  COMMENT "Generating Ice Sources from ${ice_file_FILE_NAME}..."
   )
endfunction()
