namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Nick",
                 email: "nickwtf@gmail.com",
                 password: "password",
                 password_confirmation: "password",
                 admin: true)
    User.create!(name: "Becky",
                 email: "beckychamplin82@gmail.com",
                 password: "password",
                 password_confirmation: "password",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 5)
    1.times do
      title = Faker::Lorem.sentence(1)
      content = Faker::Lorem.sentence(100)
      users.each { |user| user.posts.create!(title: title, content: content) }
    end
  end
end