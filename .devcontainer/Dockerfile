FROM mcr.microsoft.com/devcontainers/typescript-node:20

# Install Flutter
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable /opt/flutter
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Install Android SDK
RUN mkdir -p /opt/android-sdk
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${PATH}"

RUN curl -o android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip android-sdk.zip -d /opt/android-sdk && \
    rm android-sdk.zip

RUN yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses
RUN /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# Install Java 17
RUN apt-get update && apt-get install -y openjdk-17-jdk && rm -rf /var/lib/apt/lists/*

# Set up workspace
WORKDIR /workspace
RUN chown -R node:node /workspace

USER node
