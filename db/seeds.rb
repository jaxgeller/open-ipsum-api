User.create(username: 'jackson', email: 'jackson@gmail.com', password: 'password')
User.create(username: 'geller', email: 'geller@gmail.com', password: 'password')
User.create(username: 'robert', email: 'robert@gmail.com', password: 'password')

Ipsum.create(title: 'Startup Ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt quod optio corrupti, facere maiores. Assumenda, minus voluptatum magni itaque porro sequi et necessitatibus! Cum, praesentium! Maxime dolore laboriosam, aliquid modi.', user: User.last)

Ipsum.create(title: 'Arrested Ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt quod optio corrupti, facere maiores. Assumenda, minus voluptatum magni itaque porro sequi et necessitatibus! Cum, praesentium! Maxime dolore laboriosam, aliquid modi.', user: User.first)

Ipsum.create(title: 'Super Hero Ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt quod optio corrupti, facere maiores. Assumenda, minus voluptatum magni itaque porro sequi et necessitatibus! Cum, praesentium! Maxime dolore laboriosam, aliquid modi.', user: User.all.sample)

Ipsum.create(title: 'VC Ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt quod optio corrupti, facere maiores. Assumenda, minus voluptatum magni itaque porro sequi et necessitatibus! Cum, praesentium! Maxime dolore laboriosam, aliquid modi.', user: User.all.sample)

Ipsum.create(title: 'Batman Ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt quod optio corrupti, facere maiores. Assumenda, minus voluptatum magni itaque porro sequi et necessitatibus! Cum, praesentium! Maxime dolore laboriosam, aliquid modi.', user: User.all.sample)

Ipsum.create(title: 'Business Ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt quod optio corrupti, facere maiores. Assumenda, minus voluptatum magni itaque porro sequi et necessitatibus! Cum, praesentium! Maxime dolore laboriosam, aliquid modi.', user: User.all.sample)
