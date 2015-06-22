FROM ruby:2.2

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 3.2.18

RUN gem install rails --version "$RAILS_VERSION"

ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN cd /tmp && bundle install
RUN mkdir -p /var/www/ && cp -a /tmp /var/www/
WORKDIR /tmp/

RUN bundle install

VOLUME /var/log/www/

ADD . /var/www/

WORKDIR /var/www/


CMD . /var/www/.env && rails s
EXPOSE 3000
