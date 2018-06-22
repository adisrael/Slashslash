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
user4 = User.create(userName: 'regular', firstName: 'aname', lastName: 'anothername', role: 1, email: 'regular@uc.cl', password: 'asdfasdf', reputation: 0)
sports = Forum.create({title: 'Sports', description: 'This is a forum for sports enthuast', votos:0})
movies = Forum.create({title: 'Movies', description: 'This is a forum for movies enthuast', votos:0})
science = Forum.create({title: 'Science', description: 'This is a forum for science enthuast', votos:0})
p1 = Publication.create({numero: 1, title:'Premier League',content:'Which is the best team right now?', user:user1, forum:sports, votos:0})
p2 = Publication.create({numero: 2, title:'Fifa World Cup',content:'Which team will win?', user:user1, forum:sports, votos:0})
p3 = Publication.create({numero: 3, title:'Hollywood',content:'Which is the best movie right now?', user:user1, forum:movies, votos:0})
p4 = Publication.create({numero: 4, title:'DIY experiments',content:'Mentos on Coke', user:user2, forum:science, votos:0})
p5 = Publication.create({numero: 5, title:'Theory of General Relativity',content:'¿Anyone understands it?', user:user2, forum:science, votos:0})
p6 = Publication.create({numero: 6, title:'Ruby on Rails',content:'Can we use the forum gem?', user:user3, forum:science, votos:0})

require 'faker'

# Create Users
users_array = Array.new
users_array.push(user1, user2, user3, user4)
for i in 0..30
  user = User.create({
             firstName: Faker::Name.first_name,
             lastName: Faker::Name.last_name,
             userName: Faker::Internet.user_name(:firstName),
             role:1,
             email: Faker::Internet.free_email(:firstName),
             password: Faker::Internet.password(8),
             reputation:0,
             created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
             })
    users_array.push(user)
end

# Create Forums
forums_array = Array.new
quotes = Forum.create({
          title: 'Quotes',
          description: Faker::MostInterestingManInTheWorld.quote,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
hp = Forum.create({
          title: 'Harry Potter Fan Page',
          description: Faker::HarryPotter.quote,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
got = Forum.create({
  title: 'Winter is coming!',
  description: Faker::GameOfThrones.quote,
  votos:0,
  created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
tv = Forum.create({
  title: 'TV Series',
  description: 'Come to discuss the best shows!',
  votos:0,
  created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
dog = Forum.create({
  title: 'Dog Lovers',
  description: 'If you love doggies as much as we do! Then this is your place to be!',
  votos:0,
  created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
chn = Forum.create({
  title: 'Chuck Norris',
  description: Faker::ChuckNorris.fact,
  votos:0,
  created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
forums_array.push(sports, movies, science, quotes, hp, got, tv, dog, chn)

# Create Publications
i = 7
pubs_array = Array.new
pubs_array.push(p1, p2, p3, p4, p5, p6)
pub = Publication.create({
          numero: i,
          title: Faker::MostInterestingManInTheWorld.quote,
          content: Faker::Lorem.sentence,
          user: users_array.sample,
          forum: quotes,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::MostInterestingManInTheWorld.quote,
          content: Faker::Lorem.sentence,
          user: users_array.sample,
          forum: quotes,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::MostInterestingManInTheWorld.quote,
          content: Faker::Lorem.sentence,
          user: users_array.sample,
          forum: quotes,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::Matz.quote,
          content: Faker::Lorem.sentence,
          user: users_array.sample,
          forum: quotes,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::Matz.quote,
          content: Faker::Lorem.sentence,
          user: users_array.sample,
          forum: quotes,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1


pub = Publication.create({
          numero: i,
          title: Faker::ChuckNorris.fact,
          user: users_array.sample,
          forum: chn,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::ChuckNorris.fact,
          user: users_array.sample,
          forum: chn,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1

pub = Publication.create({
          numero: i,
          title: Faker::HarryPotter.quote,
          user: users_array.sample,
          forum: hp,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::HarryPotter.quote,
          user: users_array.sample,
          forum: hp,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::HarryPotter.house,
          user: users_array.sample,
          forum: hp,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1

pub = Publication.create({
          numero: i,
          title: Faker::GameOfThrones.quote,
          user: users_array.sample,
          forum: got,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::GameOfThrones.quote,
          user: users_array.sample,
          forum: got,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::GameOfThrones.dragon,
          user: users_array.sample,
          forum: got,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::GameOfThrones.house,
          user: users_array.sample,
          forum: got,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1

pub = Publication.create({
          numero: i,
          title: Faker::Friends.quote,
          user: users_array.sample,
          forum: tv,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::Friends.quote,
          user: users_array.sample,
          forum: tv,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::Friends.quote,
          user: users_array.sample,
          forum: tv,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1

pub = Publication.create({
          numero: i,
          title: Faker::Dog.meme_phrase,
          user: users_array.sample,
          forum: dog,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1
pub = Publication.create({
          numero: i,
          title: Faker::Dog.meme_phrase,
          user: users_array.sample,
          forum: dog,
          votos:0,
          created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
          })
pubs_array.push(pub)
i += 1

# Create subscriptions
for i in 0..25
  Subscription.create({
            user: users_array.sample,
            forum: forums_array.sample,
            created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
end

# Create Favorites (Starred)
for i in 0..25
  Favorite.create({
            user: users_array.sample,
            publication: pubs_array.sample,
            created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
end

# Create Comments

num_comments = 20
prng = Random.new
comm_array = Array.new

for i in 0..num_comments
  c = Comment.create({
            user: users_array.sample,
            commentable_type: 'Publication',
            commentable_id: prng.rand(Publication.all.count),
            content: Faker::MostInterestingManInTheWorld.quote,
            votos: 0,
            created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
  comm_array.push(c)
end

for i in 0..10
  c = Comment.create({
            user: users_array.sample,
            commentable_type: 'Comment',
            commentable_id: prng.rand(num_comments),
            content: Faker::MostInterestingManInTheWorld.quote,
            votos: 0,
            created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
  })
  comm_array.push(c)
end

# Create Moderators
for i in 0..10
  Moderator.create({
    approved: Faker::Boolean.boolean,
    user: users_array.sample,
    forum: forums_array.sample,
    created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
    })
end

# Create votes
for i in 0..20
  Vote.create({
    user: users_array.sample,
    publication: pubs_array.sample,
    positive: Faker::Boolean.boolean,
    created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
    })
end

# Create vote comments
for i in 0..10
  VoteComment.create({
    user: users_array.sample,
    comment: comm_array.sample,
    positive: Faker::Boolean.boolean,
    created_at: Faker::Date.between_except(60.days.ago, Date.today, Date.today)
    })
end
