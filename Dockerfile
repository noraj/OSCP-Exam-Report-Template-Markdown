FROM ubuntu:20.04

LABEL maintainer="@noraj"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt -y install texlive-latex-recommended texlive-fonts-extra texlive-latex-extra pandoc p7zip-full

# Add repository
RUN cd /root && mkdir report-generator
ADD . /root/report-generator

ADD eisvogel.latex /usr/share/pandoc/data/templates/

# Defaults
VOLUME /root/report-generator/output
VOLUME /root/report-generator/src
WORKDIR /root/report-generator

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]