require 'spec_helper'

describe Comment do
  subject { Comment.new }

  it { should respond_to :text}

  it "no comments in database" do
    expect(Comment).to have(:no).records
  end

  it "adding comment into database" do
    FactoryGirl.create(:comment)
    expect(Comment).to have(1).record
  end

  describe "validation" do
    context "with comment text" do
    	it {expect(FactoryGirl.build(:comment)).to be_valid}

      it {expect(FactoryGirl.build(:comment)).to have(:no).error_on(:text)}
    end

    context "without text" do
      it {expect(FactoryGirl.build(:comment, text: nil)).to have(2).error_on(:text)}

    	it {expect(FactoryGirl.build(:comment, text: nil)).not_to be_valid}

      it {expect(FactoryGirl.build(:comment, text: nil).errors_on(:text)).to include("can't be blank")}

      it {expect(FactoryGirl.build(:comment, text: 'a' * 350)).not_to be_valid}

      it {expect(FactoryGirl.build(:comment, text: 'a' * 350).errors_on(:text)).to include("is too long (maximum is 300 characters)")}
    end
  end

end
