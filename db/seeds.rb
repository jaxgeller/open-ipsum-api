100.times do
  User.create(
    email: Faker::Internet.free_email,
    username: Faker::Internet.user_name,
    password: Faker::Internet.password
  )
end

300.times do
  Ipsum.create(
    title: "#{Faker::Book.title} #{Faker::Company.name}",
    text: Faker::Lorem.paragraphs.join(' ')
  )
end
