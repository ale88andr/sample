# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hotel do
    sequence(:title) { |i| "Hotel #{i}" }
    room_description "------1"
    breakfast        true
    price_for_room   300
  end
end
