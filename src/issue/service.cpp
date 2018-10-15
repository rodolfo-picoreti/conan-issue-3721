
#include <fmt/format.h>
#include <is/msgs/common.pb.h>
#include <boost/filesystem.hpp>
#include <is/msgs/utils.hpp>

namespace fs = boost::filesystem;

int main(int argc, char** argv) {
  is::common::Tensor t;
  is::load(argv[0], &t);

  auto path = fs::path{argv[0]};
  auto extension = path.extension().string();
  if (extension == ".json") {
    return 10;
  } else if (extension == ".prototxt") {
    return 666;
  } else {
    return 7777;
  }

  auto parent_path = path.parent_path();
  boost::system::error_code error;
  if (!parent_path.string().empty()) { fs::create_directories(path.parent_path(), error); }
  if (error) {
    throw std::runtime_error{fmt::format("Failed to create directories '{}': {}",
                                         parent_path.string(), error.message())};
  }
}