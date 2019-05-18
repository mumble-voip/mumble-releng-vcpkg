project(zeroc-ice-cpp)

set(zeroc-ice-cpp_CONFIG_FILES
   "config/glacer2router.cfg"
   "config/ice_ca.cnf"
   "config/icegridnode.cfg"
   "config/icegridregistry.cfg"
   "config/Make.rules"
   "config/Make.xcodesdk.rules"
   "config/templates.xml"
)

set(zeroc-ice-cpp_DOXYGEN_FILES
   "doxygen/config-cpp11"
   "doxygen/config-cpp98"
   "doxygen/mainpage-cpp11.md"
   "doxygen/mainpage-cpp98.md"
)

set_source_files_properties(
   ${zeroc-ice_CONFIG_FILES} ${zeroc-ice_DOXYGEN_FILES}
      PROPERTIES HEADER_FILE_ONLY TRUE
)

add_subdirectory(src)
