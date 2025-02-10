cmake_minimum_required(VERSION 3.20)

set(CMAKE_C_COMPILER		"clang")
set(CMAKE_CXX_COMPILER		"clang++")
set(CMAKE_ASM_NASM_COMPILER		"nasm")
set(CMAKE_AR				"llvm-ar")
set(CMAKE_OBJCOPY			"llvm-objcopy")
set(CMAKE_BUILD_TYPE 		"Debug")

project(xCore LANGUAGES C CXX ASM_NASM)

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
set(CMAKE_CXX_STANDARD 23)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	message(STATUS "Build type: Debug")
	set(build_option "-O0")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
	message(STATUS "Build type: Release")
	set(build_option "-O2")
else()
	message(FATAL_ERROR "Unsupported build type: ${CMAKE_BUILD_TYPE}")
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${build_option}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${build_option}")
set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} ${build_option}")

set(CMAKE_C_FLAGS	"${CMAKE_C_FLAGS} -ffreestanding -mno-red-zone -nostdlib -nostartfiles -mcmodel=large -m64")
set(CMAKE_CXX_FLAGS	"${CMAKE_C_FLAGS} -ffreestanding -mno-red-zone -nostdlib -nostartfiles -mcmodel=large -m64 -fno-rtti -fno-exceptions")

add_subdirectory(kernel)
