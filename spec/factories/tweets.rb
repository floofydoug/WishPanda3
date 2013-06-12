# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    user_id 1
    tweet_text "MyText"
    screen_name "MyString"
  end
end
