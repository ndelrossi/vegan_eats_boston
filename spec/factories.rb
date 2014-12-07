FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    active true

    factory :inactive_user do
      active false
    end

    factory :admin do
      admin true
    end
  end

  factory :post do
    title "Title"
    content "Lorem ipsum"
    user
  end

  factory :place do
    name "Example Place"
    url_website "www.exampleplace.com"
    url_menu "www.exampleplace.com/menu"
    address_line_1 "100 Mass Ave"
    address_line_2 "Floor 2"
    address_city "Cambridge"
    address_state "MA"
    address_zip_code "02139"
    phone_number "555-555-5555"
  end

  factory :review do
    content "This is a review"
    rating 5
    user
    place
  end
end
