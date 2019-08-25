# handle slice building so the projects that need it can call it
# Types:
# slice2_bin - name_of_slice2_bin (compiled bin)
# slice_path - root/slice
# slice_dir - name of folder (i.e. "Ice")
# slice_outputs - source filename and types for the specific language

function(CompileSlices slice2_bin slice_path ice_file slice_outputs)
   add_custom_command(OUTPUT ${slice_outputs}
      COMMAND ${slice2_bin} -I${slice_path} ${ice_file}
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      #PRE_BUILD
      DEPENDS ${ice_file} ${slice2_bin}
   )
endfunction()
