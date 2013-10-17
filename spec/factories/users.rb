FactoryGirl.define do
  factory :user do
    sequence(:name)				{|i| "name #{i}"}
    sequence(:email)			{|i| "email#{i}@mail.com"}
    password							"Pa$$w0rd"
    password_confirmation	"Pa$$w0rd"
  end
end