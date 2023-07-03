FROM ruby:2.7.5

RUN apt-get update && apt-get install -qq -y build-essential nodejs default-libmysqlclient-dev --fix-missing --no-install-recommends

WORKDIR /tmp
RUN apt-get update && \
    apt-get install --no-install-recommends -y curl && \
    curl http://sphinxsearch.com/files/sphinx-3.2.1-f152e0b-linux-amd64.tar.gz -o sphinx.tar.gz && \
    mkdir sphinx && \
    tar xfz sphinx.tar.gz -C sphinx/ && \
    rm sphinx.tar.gz && \
    rm -rf /var/lib/apt/lists/*

RUN cp /tmp/sphinx/sphinx-3.2.1/bin/* /usr/local/bin/

RUN mkdir /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
