-- return a new array containing the concatenation of all of its
-- parameters. Scaler parameters are included in place, and array
-- parameters have their values shallow-copied to the final array.
-- Note that userdata and function values are treated as scalar.
function array_concat(...)
    local t = {}
    for n = 1,select("#",...) do
        local arg = select(n,...)
        if type(arg)=="table" then
            for _,v in ipairs(arg) do
                t[#t+1] = v
            end
        else
            t[#t+1] = arg
        end
    end
    return t
end

NAME             = "mouse-detector"
FILES            = {
                      "**.h",
                      "**.cpp",
                      "**.hpp",
                      "**.c"
                    }

DEBUG_LINKS      = {}
RELEASE_LINKS    = {}
INC_DIRS         = { "src/**" }
EXCLUDES         = {}
LIB_DIRS         = {}
BUILD_OPTS       = {}
DEBUG_BUILD_OPTS = {}
LINK_OPTS        = {}
DEFINES          = {}
DEBUG_DEFINES    = { "DEBUG" }
RELEASE_DEFINES  = { "NDEBUG" }
PLATFORMS        = { "x32" }
POST_BUILD_CMDS  = {}

if os.is("macosx") then

  KIND          = "ConsoleApp"
  FILES         = array_concat(FILES, { "**.mm" })
  DEBUG_LINKS   = {
                    "manymouse",
                    "CoreFoundation.framework",
                    "AppKit.framework",
                    "IOKit.framework"
                  }
  RELEASE_LINKS = DEBUG_LINKS
  INC_DIRS      = array_concat(inc, { "/Users/spmonahan/Dev/libs/bin/include/" })
  LIB_DIRS      = array_concat(lib, { "/Users/spmonahan/Dev/libs/bin/lib/" })
  BUILD_OPTS    = "-std=c++11 -stdlib=libc++ -x objective-c++" -- <-- allows for mixing C++ and Obj-C++
  LINK_OPTS     = "-stdlib=libc++" --"-mmacosx-version-min=10.7"
  DEFINES       = {}
  POST_BUILD_CMDS = {}

elseif os.is("windows") then

  KIND     = "ConsoleApp"
  -- FILES
  -- The order is EXTREMELY important
  local links      = {
                        "ws2_32",
                        "gdi32",
                        "opengl32",
                        "winmm",
                        "manymouse"
                      }

  DEBUG_LINKS      = array_concat (
                      {},
                      links )

  RELEASE_LINKS    = array_concat (
                      {},
                      links )

  GCC_VERSION      = ""

  INC_DIRS         = array_concat(
                      INC_DIRS,
                      { "E:/Dev/libs/bin/gcc-4.8.1/include", "src" } )

  LIB_DIRS         = { "E:/Dev/libs/bin/gcc-4.8.1/lib" }
  BUILD_OPTS       = "-std=c++11"
  DEBUG_BUILD_OPTS = "-g"
  --LINK_OPTS
  DEFINES          = { "GLEW_STATIC", "SFML_STATIC", "UNICODE", "_UNICODE" }
  PLATFORMS        = {}

elseif os.is("linux") then

  KIND     = "ConsoleApp"
  LIB_DIRS = {}
  DEFINES  = { "AN_LINUX" }

end


solution(NAME)
  configurations { "Debug", "Release" }

  project(NAME)
    kind(KIND)
    language "C++"
    files(FILES)
    excludes(EXCLUDES)
    libdirs(LIB_DIRS)
    includedirs(INC_DIRS)
    defines(DEFINES)
    buildoptions(BUILD_OPTS)
    linkoptions(LINK_OPTS)
    platforms(PLATFORMS)
    postbuildcommands(POST_BUILD_CMDS)

    configuration "Debug"
      links(DEBUG_LINKS)
      defines(DEBUG_DEFINES)
      buildoptions(DEBUG_BUILD_OPTS)
      flags {
        "Symbols"
      }

    configuration "Release"
      links(RELEASE_LINKS)
      defines(RELEASE_DEFINES)