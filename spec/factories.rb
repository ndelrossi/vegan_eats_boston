FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    active true

    factory :admin do
      admin true
    end
  end

  factory :post do
    title "Title"
    content "Lorem ipsum"
    approved true
    user
  end

  factory :comment do
    content "Comment Test"
    post
    user
  end

  factory :place do
    name "Example Place"
    url_website "www.exampleplace.com"
    url_menu "www.exampleplace.com/menu"
    address_line_1 "11 Example Ave"
    address_line_2 "Floor 2"
    address_city "Boston"
    address_state "MA"
    address_zip_code "02108"
    phone_number "555-555-5555"
  end
end