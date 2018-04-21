# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create({userName: 'yanavon', firstName: 'Yoav', lastName:'Navon',role:0,email:'yanavon@uc.cl', password:'asdfasdf'})
user2 = User.create({userName: 'adisrael', firstName: 'Alex', lastName:'Israel',role:0,email:'adisrael@uc.cl', password:'asdfasdf'})
forum1 = Forum.create({title: 'Sports', description: 'This is a forum for sports enthuast'})
Forum.create({title: 'Movies', description: 'This is a forum for movies enthuast'})
Forum.create({title: 'Science', description: 'This is a forum for science enthuast'})
puts(user1.userName)
Publication.create({numero: 1, title:'Premier League',content:'Which is the best team right now?', user:user1, forum:forum1})
