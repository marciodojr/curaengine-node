FROM ambientum/node:current

ARG PROTOBUF_VERSION=3.7.0
ARG CURAENGINE_VERSION=4.0.0

ENV PROTOBUF_VERSION=${PROTOBUF_VERSION}
ENV CURAENGINE_VERSION=${CURAENGINE_VERSION}

RUN sudo apk add --no-cache build-base autoconf cmake git python3-dev python3 py3-sip-dev py3-sip protobuf-dev && sudo pip3 install --upgrade pip \
    && sudo pip3 install setuptools && \
# PROTOBUF
    cd ~ && curl -L "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-python-${PROTOBUF_VERSION}.tar.gz" | tar xz \
    && cd protobuf-${PROTOBUF_VERSION} \
    && cd python && python3 setup.py build && sudo python3 setup.py install && \
# LIBARCUS
    cd ~ && git clone https://github.com/Ultimaker/libArcus.git && cd libArcus && mkdir build && cd build && cmake .. -DBUILD_PYTHON=OFF && make && sudo make install && \
# CURAENGINE
    cd ~ && git clone https://github.com/Ultimaker/CuraEngine && cd CuraEngine && git checkout ${CURAENGINE_VERSION} \
    && mkdir build && cd build && cmake .. && make && sudo cp CuraEngine /usr/bin