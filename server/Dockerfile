FROM ruby:2.5.1-slim
MAINTAINER commonmodestudio@gmail.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libxslt-dev \
      libxml2-dev \
      build-essential \
      libpq-dev \
      locales \
      git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV APP_HOME /src

RUN mkdir $APP_HOME

COPY Gemfile* $APP_HOME/

WORKDIR $APP_HOME

RUN bundle install \
    --retry 30 \
    --jobs 20 \
    --without development test doc

COPY . $APP_HOME

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
