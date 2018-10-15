
#include <is/msgs/common.pb.h>
#include <is/msgs/utils.hpp>

int main(int argc, char** argv) {
  is::common::Tensor t;
  is::load(argv[0], &t);
}