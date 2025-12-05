# Container image that runs your code
FROM ubuntu

# Install helper packages
RUN apt-get update \
  && apt-get -y autoremove \
  && apt-get clean \
  && apt-get install -y -qq wget zip unzip \
  && rm -rf /var/lib/apt/lists/*

# Download codemaker cli
RUN wget https://github.com/codemakerai/codemaker-cli/releases/download/v1.3.0/codemaker-cli_Linux_x86_64.tar.gz -P / \
  && tar -xvzf /codemaker-cli_Linux_x86_64.tar.gz

# Rename the binary
RUN mv codemaker-cli codemaker

# Add codemaker cli tp PATH
ENV PATH="$PATH:/"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
