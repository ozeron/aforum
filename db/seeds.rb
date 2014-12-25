# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Discussion.destroy_all
Comment.destroy_all

admin = User.create(nickname: 'admin', password: '12345678', email: 'admin@aforum.net')
joe = User.create(nickname: 'user', password: '12345678', email: 'user@aforum.net')

dis = Discussion.create(title: 'Hello World!', description: 'This is first topic on this forum! Hooray!', user: admin)

Comment.create(content: 'Hi admin! Nice forum!', discussion: dis, user: joe)
Comment.create(content: 'Tnx! ^^', discussion: dis, user: admin)

