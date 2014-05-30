namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Nick",
                 email: "nickwtf@gmail.com",
                 password: "biggestlie12",
                 password_confirmation: "biggestlie12",
                 admin: true)
    User.create!(name: "Becky",
                 email: "beckychamplin82@gmail.com",
                 password: "Somerset",
                 password_confirmation: "Somerset",
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
  end
end