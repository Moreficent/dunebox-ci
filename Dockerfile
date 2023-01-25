ARG base_img=azul/zulu-openjdk:11-jre-headless@sha256:d915fb7409160a845835043536b461f99f68223a80a00af272c1867f1471efbd

FROM ${base_img} as setup

ARG oda_version=6.0.0

RUN apt-get update \
  && apt-get install -y \
  unzip \
  wget

RUN useradd -ms /bin/bash eru

USER eru
WORKDIR /home/eru
ENV DEBIAN_FRONTEND noninteractive

# adb setup

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip \
  && unzip commandlinetools-linux-9123335_latest.zip \
  && mkdir -p Android/Sdk/cmdline-tools/latest \
  && mv cmdline-tools/* Android/Sdk/cmdline-tools/latest/ \
  && yes | Android/Sdk/cmdline-tools/latest/bin/sdkmanager --install "platform-tools" \
  && rm commandlinetools-linux-9123335_latest.zip \
  && rmdir cmdline-tools \
  && rm -r .android

# oda setup

RUN wget https://moreficent-oda-binary.s3.ap-south-1.amazonaws.com/${oda_version}/oda_linux_x64 -O oda \
  && chmod +x oda

FROM ${base_img}

COPY --from=setup /home/eru /setup