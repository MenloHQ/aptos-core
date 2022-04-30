FROM amazonlinux:2
RUN amazon-linux-extras install docker
RUN docker --version