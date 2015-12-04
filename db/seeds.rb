User.create(username: 'jackson', email: 'jackson@gmail.com', password: 'password', password_confirmation: 'password')
User.create(username: 'geller', email: 'geller@gmail.com', password: 'password', password_confirmation: 'password')
User.create(username: 'robert', email: 'robert@gmail.com', password: 'password', password_confirmation: 'password')

startup_ipsum = File.open("db/ipsum_data/startup_ipsum.txt", "r").read
Ipsum.create(title: 'Startup Ipsum', text: startup_ipsum, user: User.first, g_markov: false)

hipster_ipsum = File.open("db/ipsum_data/hipster_ipsum.txt", "r").read
Ipsum.create(title: 'Hipster Ipsum', text: hipster_ipsum, user: User.all.sample, g_markov: false)

bluth_ipsum = File.open("db/ipsum_data/bluth_ipsum.txt", "r").read
Ipsum.create(title: 'Bluth Ipsum', text: bluth_ipsum, user: User.last)

Ipsum.create(title: 'Lorem Ipsum', text: Faker::Lorem.paragraphs.join(' '), user: User.all.sample)
Ipsum.create(title: 'Merol Ipsum', text: Faker::Lorem.paragraphs.join(' '), user: User.all.sample)
