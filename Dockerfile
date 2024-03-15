FROM ubuntu:latest


# Install additional dependencies
RUN apt-get update && \
    apt-get install -y git \
		make \
		gcc \
		pkg-config \
		libx11-dev libxkbfile-dev \
		libsecret-1-dev \
		curl \
		npm \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


SHELL ["/bin/bash", "--login", "-i", "-c"]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

RUN source /root/.bashrc && nvm install 16.15.1

RUN nvm use 16.15.1

RUN nvm list

RUN git clone https://github.com/eclipse-theia/theia

RUN chmod 777 /theia

WORKDIR /theia

RUN npm install --global yarn

RUN yarn

RUN yarn browser build

RUN touch start.py

RUN echo "white true: print("aboba")" > start.py

RUN chmod 777 start.py

cd theia/plugins/tabby

SHELL ["/bin/bash", "--login", "-c"]


# Expose the port for the TabbyML API
EXPOSE 3000

EXPOSE 8080


ENTRYPOINT echo $SHELL && npm install --global yarn && source /root/.nvm/nvm.sh && nvm --version && cd /theia && yarn browser start