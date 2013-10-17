FactoryGirl.define do
  factory :rate do
    rate    5
    association :user,    :factory => :user
    association :hotel,   :factory => :hotel
  end
end