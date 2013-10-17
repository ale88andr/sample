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

  context "records" do
    it "no hotels in database" do
      expect(Hotel).to have(:no).records
    end

    it "hotels records should be added" do
      FactoryGirl.create(:hotel)
      expect(Hotel).to have(1).records
    end
  end

  describe "validates" do
    context "with valid data" do
      it {expect(FactoryGirl.build(:hotel)).to be_valid}

      it {expect(FactoryGirl.build(:hotel)).to have(:no).error_on(:title)}

      it {expect(FactoryGirl.build(:hotel)).to have(:no).error_on(:price_for_room)}
    end

    context "with invalid data" do

      it {expect(FactoryGirl.build(:hotel, title: nil)).to have(2).error_on(:title)}

      it {expect(FactoryGirl.build(:hotel, price_for_room: 'abc')).to have(2).error_on(:price_for_room)}

      it {expect(FactoryGirl.build(:hotel, price_for_room: -5)).to have(2).error_on(:price_for_room)}

      it {expect(FactoryGirl.build(:hotel, title: nil).errors_on(:title)).to include("can't be blank")}

      it {expect(FactoryGirl.build(:hotel, price_for_room: 'zzz').errors_on(:price_for_room)).to include("this field can only contain numeric")}

      it "has empty title" do
        expect(FactoryGirl.build(:hotel, title: nil)).not_to be_valid
      end

      it "price_for_room is not numeric" do
        expect(FactoryGirl.build(:hotel, price_for_room: 'abc')).not_to be_valid
      end

      it "price_for_room < 0" do
        expect(FactoryGirl.build(:hotel, price_for_room: -5)).not_to be_valid
      end
    end

    context "scopes" do
      subject {Hotel}

      it {should respond_to :chronology}

      context "by created_at" do
        let(:record1) {FactoryGirl.create(:hotel, created_at: 1.day.ago)}
        let(:record2) {FactoryGirl.create(:hotel, created_at: 1.month.ago)}

        it "with true" do
          expect(subject.chronology(1)).to eq([record2, record1])
        end

        it "with false" do
          expect(subject.chronology(nil)).to eq([record1, record2])
        end
      end

    end
  end

end
