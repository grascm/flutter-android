ARG BUILDTOOLS_VERSION=30
FROM grascm/android-buildtools:$BUILDTOOLS_VERSION

RUN apt update \
    && apt install -y \
        protobuf-compiler \
        xz-utils \
        git \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_2.0.5-stable.tar.xz \
    /tmp/flutter-tools.tar.xz

ENV FLUTTER_SDK_ROOT="/opt/flutter-sdk"

RUN mkdir -p "$FLUTTER_SDK_ROOT" && \
    cd "$FLUTTER_SDK_ROOT" && \
    tar xf /tmp/flutter-tools.tar.xz

ENV PATH="$PATH:$FLUTTER_SDK_ROOT/flutter/bin/:~/.pub-cache/bin/"

RUN flutter precache && flutter config --no-analytics
RUN dart pub global activate protoc_plugin
