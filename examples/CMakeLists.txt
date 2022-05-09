add_subdirectory(qftp)

#INSTALL RULES
install(
  DIRECTORY .
  DESTINATION include
  COMPONENT headers
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)
