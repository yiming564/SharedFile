add_executable(xCore)

set(KERNEL_LDS ${CMAKE_CURRENT_SOURCE_DIR}/kernel.lds)

set_target_properties(
	xCore PROPERTIES
	LINKER_LANGUAGE C
	LINK_DEPENDS ${KERNEL_LDS}
)

target_include_directories(
	xCore PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}/asm
)

add_subdirectory(init)

target_link_options(
	xCore PRIVATE
	-fuse-ld=lld
	-ffreestanding
	-nostdlib
	-Wl,-T,${KERNEL_LDS}
)
