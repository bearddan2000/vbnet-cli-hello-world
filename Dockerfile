FROM ubuntu:20.04

ARG IN_FILE="Application.vb"
ARG OUT_FILE="Application.exe"

COPY bin/ .

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      apt-transport-https \
      dirmngr \
      gpg-agent \
      software-properties-common

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && apt update \
    && apt-get install -y mono-complete \
    && apt-get install -y mono-vbnc \
    && chmod +x ${IN_FILE} \
    && vbnc ${IN_FILE} \
    && chmod +x ${OUT_FILE}

CMD ["mono", "Application.exe"]
