cmake_minimum_required(VERSION 3.25)

include_guard(GLOBAL)

if(DEFINED ENV{PICOTOOL_PATH} AND (NOT PICOTOOL_PATH))
  set(PICOTOOL_PATH $ENV{PICOTOOL_PATH})
  message("Using PICOTOOL_PATH from environment ('${PICOTOOL_PATH}')")
endif()

if(DEFINED ENV{PICOTOOL_FETCH_FROM_GIT} AND (NOT PICOTOOL_FETCH_FROM_GIT))
  set(PICOTOOL_FETCH_FROM_GIT $ENV{PICOTOOL_FETCH_FROM_GIT})
  message("Using PICOTOOL_FETCH_FROM_GIT from environment
    ('${PICOTOOL_FETCH_FROM_GIT}')")
endif()

if(DEFINED ENV{PICOTOOL_FETCH_FROM_GIT_PATH}
   AND (NOT PICOTOOL_FETCH_FROM_GIT_PATH))
  set(PICOTOOL_FETCH_FROM_GIT_PATH $ENV{PICOTOOL_FETCH_FROM_GIT_PATH})
  message("Using PICOTOOL_FETCH_FROM_GIT_PATH from environment
    ('${PICOTOOL_FETCH_FROM_GIT_PATH}')")
endif()

if(DEFINED ENV{PICOTOOL_FETCH_FROM_GIT_TAG}
   AND (NOT PICOTOOL_FETCH_FROM_GIT_TAG))
  set(PICOTOOL_FETCH_FROM_GIT_TAG $ENV{PICOTOOL_FETCH_FROM_GIT_TAG})
  message("Using PICOTOOL_FETCH_FROM_GIT_PATH from environment
    ('${PICOTOOL_FETCH_FROM_GIT_TAG}')")
endif()

if (PICOTOOL_FETCH_FROM_GIT AND NOT PICOTOOL_FETCH_FROM_GIT_TAG)
  set(PICOTOOL_FETCH_FROM_GIT_TAG "master")
  message("Using master as default tag for PICOTOOL_FETCH_FROM_GIT_TAG")
endif()

set(PICOTOOL_PATH ${PICOTOOL_PATH} CACHE PATH "Path to picotool")
set(PICOTOOL_FETCH_FROM_GIT ${PICOTOOL_FETCH_FROM_GIT} CACHE BOOL
  "Whether to fetch picotool from git")
set(PICOTOOL_FETCH_FROM_GIT_TAG ${PICOTOOL_FETCH_FROM_TAG} CACHE STRING
  "picotool git tag")
set(PICOTOOL_FETCH_FROM_GIT_PATH ${PICOTOOL_FETCH_FROM_PATH} CACHE PATH
  "Path where to store picotool fetched from git")

find_program(PICOTOOL_EXEC picotool HINTS PICOTOOL_PATH)

function(create_flash_target PICO_FLASH_TARGET)
  if(PICOTOOL_EXEC)
    add_custom_target(flash
      COMMAND ${PICOTOOL_EXEC} load -fx $<TARGET_FILE:${PICO_FLASH_TARGET}>
      DEPENDS ${PICO_FLASH_TARGET}
      COMMENT "Flashing master to Raspberry Pi Pico"
      EXECLUDE_FROM_ALL FALSE
      USES_TERMINAL
      VERBATIM
    )
  else()
    message(WARNING "picotool not found! 'flash' target will not be available.")
  endif()
endfunction()
