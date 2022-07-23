# escape=\

FROM docker.io/elixir:otp-25


RUN apt-get update -y \
    && apt-get upgrade -y

RUN apt-get install -y build-essential curl vim \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /usr/local/src/* \
    /tmp/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init.sh \
    && chmod +x rustup-init.sh \
    && ./rustup-init.sh -y \
    && rm rustup-init.sh

# .bashrc とか .vimrc とかは適当に用意
# COPY bashrc-copy . 
# COPY .vimrc .
# RUN mv bashrc-copy ~/.bashrc && mv .vimrc ~/.vimrc

WORKDIR /ex-book

# Force shell to use pipenv
ENTRYPOINT ["/bin/bash"]
