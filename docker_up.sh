docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web rails db:seed
docker-compose up 
