# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :penalty do
      user_id 1
      point_value 1
      comments "MyText"
    end
end