FROM debian:stable-slim

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
      grep \
      libseccomp-dev \
      libseccomp2 \
      procps \
    && rm -rf /var/lib/apt/lists/*

    
# Download LLVM repository key
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# Add LLVM repository to sources.list
RUN echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-8 main" >> /etc/apt/sources.list \
  && echo "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-8 main" >> /etc/apt/sources.list

# Install required packages
RUN apt-get update && apt-get -y --no-install-recommends install \
    clang-8 \
    cmake \
    make

# Set symbolic links for clang and clang++
RUN ln -s /usr/bin/clang-8 /usr/bin/clang \
  && ln -s /usr/bin/clang++-8 /usr/bin/clang++

# Clean up
RUN apt-get purge -y --auto-remove wget gnupg \
  && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
