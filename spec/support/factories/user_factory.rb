FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@ticketee.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :confirmed_user do
      after_create do|user|
        user.confirm!
      end
    end
  end
end