require 'spec_helper'

describe Hotel do
  subject { Hotel.new }

  it{ should respond_to :title }
  it{ should respond_to :room_description }
  it{ should respond_to :breakfast }
  it{ should respond_to :price_for_room }
  it{ should respond_to :address }

  context "relations" do
    it{ should respond_to :user }
    it{ should respond_to :comments }
    it{ should respond_to :rates }
  end

  describe "validates" do
    context "with valid data" do
      it {expect(FactoryGirl.build(:hotel)).to be_valid}
    end

    context "with invalid data" do
      it "has empty title" do
        expect(FactoryGirl.build(:hotel, title: nil)).not_to be_valid
      end

      it "price_for_room is not numeric" do
        expect(FactoryGirl.build(:hotel, price_for_room: 'abc')).not_to be_valid
      end
    end
  end

end
