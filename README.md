# README

This demonstrates running sphinx-search with thinking-sphinx gem running in docker.

* Ruby version
2.7.5

* Rails version
7.0.5

* Sphinx Search version
3.2.1
This is defined in the dockerfile.

* System dependencies
docker
docker-compose

* Database creation
rake db:create

* Database initialization
rake db:migrate

* Initialization
Terminal 1
`docker compose down && docker compose build && docker compose up`

Terminal 2
1. docker compose down && docker compose build && docker compose up
`docker compose run app bash`

```
 $ docker compose run app bash
[+] Building 0.0s (0/0)
[+] Creating 1/0
 ✔ Container tsdemo-database-1  Running                                                                                                                                                                                                        0.0s
[+] Building 0.0s (0/0)
root@71b9d3a7bf0c:/app# rake ts:configure
Generating configuration to /app/config/sphinx.conf
root@71b9d3a7bf0c:/app# rake ts:start
Sphinx 3.2.1 (commit f152e0b)
Copyright (c) 2001-2020, Andrew Aksyonoff
Copyright (c) 2008-2016, Sphinx Technologies Inc (http://sphinxsearch.com)

using config file '/app/config/sphinx.conf'...
listening on 127.0.0.1:9312
precaching index 'article_core'
precached 1 indexes in 0.028 sec
Started searchd successfully (pid: 42).
root@71b9d3a7bf0c:/app# rake ts:rebuild
Sphinx 3.2.1 (commit f152e0b)
Copyright (c) 2001-2020, Andrew Aksyonoff
Copyright (c) 2008-2016, Sphinx Technologies Inc (http://sphinxsearch.com)

using config file '/app/config/sphinx.conf'...
stop: successfully sent SIGTERM to pid 42
Stopped searchd daemon (pid: 42).
Generating configuration to /app/config/sphinx.conf
Generating configuration to /app/config/sphinx.conf
Sphinx 3.2.1 (commit f152e0b)
Copyright (c) 2001-2020, Andrew Aksyonoff
Copyright (c) 2008-2016, Sphinx Technologies Inc (http://sphinxsearch.com)

using config file '/app/config/sphinx.conf'...
indexing index 'article_core'...
collected 2 docs, 0.0 MB
sorted 0.0 Mhits, 100.0% done
total 2 docs, 0.1 Kb
total 0.1 sec, 0.6 Kb/sec, 21 docs/sec
skipping non-plain index 'article'...
Sphinx 3.2.1 (commit f152e0b)
Copyright (c) 2001-2020, Andrew Aksyonoff
Copyright (c) 2008-2016, Sphinx Technologies Inc (http://sphinxsearch.com)

using config file '/app/config/sphinx.conf'...
listening on 127.0.0.1:9312
precaching index 'article_core'
precached 1 indexes in 0.026 sec
Started searchd successfully (pid: 86).
root@71b9d3a7bf0c:/app# rails c
Loading development environment (Rails 7.0.6)
irb(main):001:0> Article.search "Top"
  Sphinx Query (26.3ms)  SELECT * FROM `article_core` WHERE MATCH('Top') AND `sphinx_deleted` = 0 LIMIT 0, 20 OPTION cutoff=0
  Sphinx  Found 1 results
  Article Load (4.3ms)  SELECT `articles`.* FROM `articles` WHERE `articles`.`id` = 2
=> [#<Article:0x000000400c90caa8 id: 2, title: "The Top 2023 Guitars", content: "Gibson and Ibanez", created_at: Sun, 02 Jul 2023 02:18:51.005149000 UTC +00:00, updated_at: Sun, 02 Jul 2023 02:18:51.005149000 UTC +00:00>]
irb(main):002:0> Article.all
  Article Load (1.4ms)  SELECT `articles`.* FROM `articles`
=>
[#<Article:0x000000400c7f1e48 id: 1, title: "Podcast", content: "The Koolpals", created_at: Sun, 02 Jul 2023 02:18:10.560357000 UTC +00:00, updated_at: Sun, 02 Jul 2023 02:18:10.560357000 UTC +00:00>,
 #<Article:0x000000400c7f1d58 id: 2, title: "The Top 2023 Guitars", content: "Gibson and Ibanez", created_at: Sun, 02 Jul 2023 02:18:51.005149000 UTC +00:00, updated_at: Sun, 02 Jul 2023 02:18:51.005149000 UTC +00:00>]
irb(main):003:0>
```

# Problems encountered
These are my settings that worked!!!!

```
default: &default
  # address: <%= ENV.fetch('SPHINX_HOST') { 'database' } %>
  mysql41: 9312
  configuration_file: "/app/config/sphinx.conf"
  pid_file: "/app/log/searchd.development.pid"
  binlog_path: "/app/tmp/binlog/development"

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
```
