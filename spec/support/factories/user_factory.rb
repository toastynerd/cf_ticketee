FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@ticketee.com"}
    password "foobar"
    password_confirmation "foobar"
  end
end