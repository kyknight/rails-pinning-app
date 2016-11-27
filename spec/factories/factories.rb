
FactoryGirl.define do
    factory :user do
        sequence(:email) { |n| "coder#{n}@skillcrush.com" }
        first_name "Michelle"
        last_name "McManus"
        password "secret"
    end
end