from conans import ConanFile, CMake, tools


class Issue3721Conan(ConanFile):
    name = "issue3721"
    version = "0.0.0"
    license = "MIT"
    url = ""
    description = ""
    settings = "os", "compiler", "build_type", "arch"
    options = {
        "shared": [True, False],
        "fPIC": [True, False],
        "build_tests": [True, False],
    }
    default_options = "shared=False", "fPIC=True", "build_tests=False"
    generators = "cmake", "cmake_find_package", "cmake_paths"
    requires = (
        "is-msgs/1.1.8@is/stable",
        "boost/1.66.0@conan/stable",
        "spdlog/1.1.0@bincrafters/stable",
    )

    exports_sources = "*"

    def configure(self):
        self.options["boost"].shared = True
        self.options["fmt"].shared = True

    def build(self):
        cmake = CMake(self, generator='Ninja')
        cmake.definitions["CMAKE_POSITION_INDEPENDENT_CODE"] = self.options.fPIC
        cmake.definitions["enable_tests"] = self.options.build_tests
        cmake.configure()
        cmake.build()

