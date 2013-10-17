require 'spec_helper'

describe User do
  subject { User.new }

  it {should respond_to :name}
  it {should respond_to :email}
  it {should respond_to :password}
  it {should respond_to :password_confirmation}

  context "relation" do
  	it {should respond_to :hotels}
  	it {should respond_to :comments}
  	it {should respond_to :rates}
  end

  describe "validates" do
  	context "valid data" do
  		it {expect(FactoryGirl.build(:user)).to be_valid}
  	end

  	context "invalid data" do
  		it "empty name" do
  			expect(FactoryGirl.build(:user, name: nil)).not_to be_valid
  		end

  		it "empty email" do
  			expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  		end

  		it "empty password" do
  			expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
  		end

  		it "wrong password_confirmation" do
  			expect(FactoryGirl.build(:user, password: 'nil', password_confirmation: 'not_nil')).not_to be_valid
  		end

  		it "email wrong format" do
  			%w[as@as 111 as.mail.com].each do |email|
  				expect(FactoryGirl.build(:user, email: email)).not_to be_valid
  			end
  		end
  	end
  end

end
