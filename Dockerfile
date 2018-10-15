ARG BASE
FROM $BASE as build

# Install build dependencies
ADD bootstrap.sh .
RUN ./bootstrap.sh 

# Install library dependencies 
ADD conanfile.py .
RUN conan install . -s compiler.libcxx=libstdc++11 --build=missing

# Build the target then copy the binary and shared libraries
ADD . /project
RUN cd /project                                                         \
 && ./build.sh                                                          \
 && mkdir -v -p /tmp/is/lib /tmp/is/bin                                 \
 && echo `find build/ -type f -name '*.bin' -exec ldd {} \;`            \
 && libs=`find build/ -type f -name '*.bin' -exec ldd {} \;             \
    | cut -d '(' -f 1 | cut -d '>' -f 2 | sort | uniq`                  \
 && for lib in $libs;                                                   \
    do                                                                  \
      dir="/tmp/is/lib`dirname $lib`";                                  \
      mkdir -v -p  $dir;                                                \
      cp --verbose $lib $dir;                                           \
    done                                                                \
 && cp --verbose `find build/ -type f -name '*.bin'` /tmp/is/bin/


FROM $BASE
COPY --from=build /tmp/is/lib/ /
COPY --from=build /tmp/is/bin/ /