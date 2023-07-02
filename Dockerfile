# FROM debian AS build
# WORKDIR /tmp
# RUN apt-get update && \
#     apt-get install --no-install-recommends -y curl && \
#     curl http://sphinxsearch.com/files/sphinx-3.2.1-f152e0b-linux-amd64.tar.gz -o sphinx.tar.gz && \
#     mkdir sphinx && \
#     tar xfz sphinx.tar.gz -C sphinx/ && \
#     rm sphinx.tar.gz && \
#     rm -rf /var/lib/apt/lists/*



# FROM ruby:2.7
# COPY --from=build /tmp/sphinx/sphinx* /opt/sphinx
# ENV PATH="/opt/sphinx/bin:$PATH"

# COPY . /app

# # Run bundler, etc.
# COPY bin/start-app /usr/local/bin/start-app
# COPY bin/start-sphinx /usr/local/bin/start-sphinx

# CMD ["/app/bin/start-app"]
FROM ruby:2.7.5

RUN apt-get update && apt-get install -qq -y build-essential nodejs --fix-missing --no-install-recommends

# RUN curl -s \
#     http://sphinxsearch.com/files/sphinxsearch_2.3.2-beta-1~wheezy_amd64.deb \
#     -o /tmp/sphinxsearch.deb \
# && dpkg -i /tmp/sphinxsearch.deb \
# && rm /tmp/sphinxsearch.deb \&& mkdir -p /var/log/sphinxsearch

RUN mkdir /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

