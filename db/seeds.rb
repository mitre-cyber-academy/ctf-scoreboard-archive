# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# default admin user - CHANGE PASSWORD!!!
Admin.create!(email: 'root', password: 'ChangePa$$w0rd')

# default game
game = Game.create!(name: 'Test Game', start: Time.now, stop: Time.now + 2.days)

# players
Player.create!(display_name: 'pwnies', email: 'pwnies', password: 'test123456', game_id: game.id)
Player.create!(display_name: 'n00bs', email: 'n00bs', password: 'test123456', game_id: game.id)

# crypto
category = Category.create!(name: 'Crypto', game: game)
Challenge.create!(name: 'Challenge A', point_value: 100, flags: [ Flag.create(flag: "flag") ], state: 'open', category: category)
Challenge.create!(name: 'Challenge B', point_value: 200, flags: [ Flag.create(flag: "flag") ], state: 'closed', category: category)
Challenge.create!(name: 'Challenge C', point_value: 300, flags: [ Flag.create(flag: "flag") ], state: 'closed', category: category)
Challenge.create!(name: 'Challenge D', point_value: 400, flags: [ Flag.create(flag: "flag") ], state: 'closed', category: category)

category = Category.create!(name: 'Forensics', game: game)
Challenge.create!(name: 'Challenge E', point_value: 100, flags: [ Flag.create(flag: "flag") ], state: 'open', category: category)
Challenge.create!(name: 'Challenge F', point_value: 200, flags: [ Flag.create(flag: "flag") ], state: 'closed', category: category)
Challenge.create!(name: 'Challenge G', point_value: 300, flags: [ Flag.create(flag: "flag") ], state: 'closed', category: category)
Challenge.create!(name: 'Challenge H', point_value: 400, flags: [ Flag.create(flag: "flag") ], state: 'closed', category: category)
