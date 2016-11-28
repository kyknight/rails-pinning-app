
FactoryGirl.define do
    factory :user do
        sequence(:email) { |n| "coder#{n}@skillcrush.com" }
        first_name "Evelyn"
        last_name "Granville"
        password "mercury"
    end
end