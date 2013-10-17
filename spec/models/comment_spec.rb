require 'spec_helper'

describe Comment do
  subject { Comment.new }

  it { should respond_to :text}

  describe "validation" do
  	it "with text" do
  		expect(FactoryGirl.build(:comment)).to be_valid
  	end

  	it "without text" do
  		expect(FactoryGirl.build(:comment, text: nil)).not_to be_valid
  	end
  end
end
