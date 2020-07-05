FROM ruby:2.7.1-alpine3.12

# 環境の設定
ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata mysql-client mysql-dev imagemagick" \
    CHROME_PACKAGES="chromium-chromedriver zlib-dev chromium xvfb wait4ports xorg-server dbus ttf-freefont mesa-dri-swrast udev" \
    DEV_PACKAGES="build-base curl-dev" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /sodateyo
WORKDIR /sodateyo

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /sodateyo/Gemfile
ADD Gemfile.lock /sodateyo/Gemfile.lock

# ライブラリのインストール
RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache $RUNTIME_PACKAGES && \
    apk add --update --virtual build-dependencies --no-cache $DEV_PACKAGES && \
    apk add --no-cache ${CHROME_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
COPY . /sodateyo

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
