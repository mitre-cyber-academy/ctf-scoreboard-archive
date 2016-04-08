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
game = Game.create!(name: 'Test Game', start: Time.now, stop: Time.now + 2.days,
  tos: "<p><strong>Rules</strong></p>\r\n<ul>\r\n<li>Absolutely no flag sharing! (Why help your competitors?)</li>\r\n
<li>You may not do anything to diminish the competition experience for other players on the system; 
if you are worried that you might break something, ask an operator in IRC (with a private message) for clarification. 
We love creativity, just clear it with us first.</li>\r\n
<li>Foul play will not be tolerated (first offense is a warning, second offense is an appropriate point deduction and 
third offense is a disqualification).</li>\r\n<li>No bullying. This includes harassment, intimidation and threats.</li>\r\n
<li>Operator decisions are final.</li>\r\n</ul>\r\n<p><strong>Etiquette</strong></p>\r\n<ul>\r\n
<li>Keep it clean in IRC and MPAA G-rated conversations, please.</li>\r\n
<li>Remember that operators in IRC channel are running the game.</li>\r\n
<li>Be a good sport throughout the competition.</li>\r\n</ul>\r\n<p><strong>Flag Format</strong></p>\r\n<ul>\r\n
<li>All flags are either of the form MCA-[8 hex digits] such as MCA-ABCDEF12 or an SHA1 hash.</li>\r\n
<li>Case does not matter when submitting to the scoreboard, it will downcase your submission automatically.</li>\r\n</ul>\r\n\r\n
<p><strong>Challenge Colors</strong></p>\r\nChallenges will sometimes show up as different colors, the possible colors and 
their meanings are as follows:\r\n<ul>\r\n<li><b style=\"color:green;\">Green:</b> Available and ready to be solved by your team.</li>\r\n
<li><b style=\"color:#08C;\">Blue:</b> Available and already solved by your team.</li>\r\n
<li><b style=\"color:DarkOrange;\">Orange:</b> Solved by a team but locked by admins due to issue with the challenge.<br /></li>\r\n
<li><b style=\"color:red;\">Red:</b> Unsolved by any team and locked by admins.</li>\r\n
<li><b style=\"color:gray;\">Gray:</b> Will open when preceding challenge is solved.</li>\r\n</ul>"
)


division1 = Division.create!(name: "High School", game_id: game.id)
division2 = Division.create!(name: "College", game_id: game.id)

# players
Player.create!(display_name: 'pwnies', email: 'pwnies', password: 'test123456', division_id: division1.id)
Player.create!(display_name: 'n00bs', email: 'n00bs', password: 'test123456', division_id: division2.id)

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
