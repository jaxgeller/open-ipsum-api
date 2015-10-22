User.create(username: 'jackson', email: 'jackson@gmail.com', password: 'password')
User.create(username: 'geller', email: 'geller@gmail.com', password: 'password')
User.create(username: 'robert', email: 'robert@gmail.com', password: 'password')

text = Faker::Lorem.paragraphs.join ' '

Ipsum.create(title: 'Startup Ipsum', text: text, user: User.first)
Ipsum.create(title: 'Super Hero Ipsum', text: text, user: User.all.sample, g_markov: false)
Ipsum.create(title: 'VC Ipsum', text: text, user: User.all.sample)
Ipsum.create(title: 'Batman Ipsum', text: text, user: User.all.sample, g_markov: false)
Ipsum.create(title: 'Business Ipsum', text: text, user: User.all.sample)
