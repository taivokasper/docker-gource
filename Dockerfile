FROM dockerfile/ubuntu

RUN apt-add-repository -y ppa:jon-severinsson/ffmpeg && \
apt-get update && \
apt-get install -y git mercurial xvfb xfonts-base xfonts-75dpi xfonts-100dpi xfonts-cyrillic gource ffmpeg

ADD ./gource_generator.bash /tmp/gource_generator.bash

VOLUME ["/repoRoot", "/avatars", "/results"]

WORKDIR /repoRoot

CMD bash /tmp/gource_generator.bash