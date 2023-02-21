# a premise: I absolutely despise CMake

cmake_minimum_required(VERSION 3.24)
project(plugins)

# add cmake utilities
#list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# 
set(manufacturer Stoejmaskiner)
set(bundle_id com.stoejmaskiner)
set(manufacturer_code Stoj)

add_subdirectory(libs)

juce_set_vst2_sdk_path("/mnt/c/VST_SDK/vst2sdk/vstsdk2.4/pluginterfaces")

add_subdirectory(modules)
add_subdirectory(plugins)