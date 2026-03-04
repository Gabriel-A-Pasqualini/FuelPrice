FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk
ENV FLUTTER_HOME=/opt/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin:$ANDROID_HOME/platform-tools

# Dependências
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa openjdk-17-jdk wget \
    clang cmake ninja-build pkg-config libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME
RUN flutter doctor

# Android tools (mínimo para build)
RUN mkdir -p $ANDROID_HOME/platform-tools

WORKDIR /app