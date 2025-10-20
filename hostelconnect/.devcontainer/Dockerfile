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
ENV PATH="/opt/flutter/bin:${PATH}"

# Install Flutter dependencies
RUN flutter doctor --android-licenses || true
RUN flutter config --no-analytics
RUN flutter precache

# Install PostgreSQL client
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

# Install additional tools
RUN npm install -g @nestjs/cli

USER node
