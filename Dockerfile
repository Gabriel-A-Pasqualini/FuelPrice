FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk
ENV FLUTTER_HOME=/opt/flutter

# PATH completo
ENV PATH=$PATH:$FLUTTER_HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-17-jdk \
    wget \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# =============================
# Flutter
# =============================
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME

# Precache inicial (não falha se faltar Android ainda)
RUN flutter doctor || true

# =============================
# Android cmdline-tools
# =============================
RUN mkdir -p $ANDROID_HOME/cmdline-tools
WORKDIR $ANDROID_HOME/cmdline-tools

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O tools.zip \
    && unzip tools.zip \
    && mv cmdline-tools latest \
    && rm tools.zip

# Aceitar licenças
RUN yes | sdkmanager --licenses

# Instalar ADB + ferramentas mínimas
RUN sdkmanager \
    "platform-tools" \
    "platforms;android-34" \
    "build-tools;34.0.0"

# Voltar para app
WORKDIR /app