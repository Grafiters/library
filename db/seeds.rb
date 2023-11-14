User.create({
    username: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: 123456,
    role: 'admin'
})

25.times do
    User.create({
        username: Faker::Name.first_name,
        email: Faker::Internet.email,
        password: SecureRandom.hex(10),
        role: ['user','admin'].sample
    })
end

25.times do
    Author.create({
        name: Faker::Name.first_name
    })
end

50.times do
    time = Faker::Time.between(from: DateTime.now.beginning_of_day, to: DateTime.now.end_of_day)
    author = Author.all.pluck(:id)

    Book.create({
        author_id: author.sample,
        title: Faker::Books::Dune.title,
        description: Faker::Lorem.paragraph(sentence_count=3),
        tgl_publish: time,
        tgl_release: time,
        total_page: rand(15..100),
        type_book: ['Fiction', 'Non-Fiction', 'Romance', 'Horror', 'History'].sample
    })
end