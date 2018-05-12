# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create({userName: 'yanavon', firstName: 'Yoav', lastName:'Navon',role:0,email:'yanavon@uc.cl', password:'asdfasdf', reputation:0})
user2 = User.create({userName: 'adisrael', firstName: 'Alex', lastName:'Israel',role:0,email:'adisrael@uc.cl', password:'asdfasdf', reputation:0})
user3 = User.create({userName: 'asdegoyeneche', firstName: 'Alfredo', lastName:'De Goyeneche',role:0,email:'asdegoyeneche@uc.cl', password:'asdfasdf', reputation:0})
sports = Forum.create({title: 'Sports', description: 'This is a forum for sports enthuast', votos:0})
movies = Forum.create({title: 'Movies', description: 'This is a forum for movies enthuast', votos:0})
science = Forum.create({title: 'Science', description: 'This is a forum for science enthuast', votos:0})
Publication.create({numero: 1, title:'Premier League',content:'Which is the best team right now?', user:user1, forum:sports, votos:0})
Publication.create({numero: 2, title:'Fifa World Cup',content:'Which team will win?', user:user1, forum:sports, votos:0})
Publication.create({numero: 3, title:'Hollywood',content:'Which is the best movie right now?', user:user1, forum:movies, votos:0})
Publication.create({numero: 4, title:'DIY experiments',content:'Mentos on Coke', user:user2, forum:science, votos:0})
Publication.create({numero: 5, title:'Theory of General Relativity',content:'¿Anyone understands it?', user:user2, forum:science, votos:0})
Publication.create({numero: 6, title:'Ruby on Rails',content:'Can we use the forum gem?', user:user3, forum:science, votos:0})
