# handle slice building so the projects that need it can call it
function(CompileSlices slice_bin slice_path ice_file_path output_dir gen_file_type)
   add_custom_command(
	  OUTPUT ${gen_file_type}
	  COMMAND "${slice_bin} -I${slice_path} ${ice_file_path}"
      WORKING_DIRECTORY ${output_dir}
	  COMMENT "Generating Ice Sources from ${ice_file_path_FILE_NAME}..."
   )
endfunction()