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

Terminal N
