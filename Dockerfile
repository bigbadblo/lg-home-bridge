FROM node:7
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app

ENV RUBY_VERSION 2.2.0
RUN curl -O http://ftp.ruby-lang.org/pub/ruby/ruby-$RUBY_VERSION.tar.gz && tar zvxf ruby-$RUBY_VERSION.tar.gz && pushd ruby-$RUBY_VERSION && ./configure && make && make install && popd && rm -rf ruby-$RUBY_VERSION.tar.gz ruby-$RUBY_VERSION

### Install bundler
RUN gem update --system
RUN gem install bundler --no-rdoc --no-ri
RUN git clone https://github.com/bigbadblo/slack-bot.git /app/slack-bot && cd /app/slack-bot && gem install bundle && bundle
RUN chmod +x start.sh
CMD ./start.sh
