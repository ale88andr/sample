require 'spec_helper'

describe Rate do
  subject {Rate.new}

  it { should respond_to :rate }
  it { should respond_to :user_id }
  it { should respond_to :hotel_id }

  context "relations" do
    it { should respond_to :user }
    it { should respond_to :hotel }
  end

  context "scopes" do
    subject {Rate}

    let(:hotel1) {FactoryGirl.create(:hotel)}
    let(:hotel2) {FactoryGirl.create(:hotel)}

    it {should respond_to :top_rate}

    xit "shows top rated hotel objects" do
      %w[1 2 3].each do |user_id|
        FactoryGirl.create(:rate, hotel_id: hotel1.id, user_id: user_id)
      end
      expect(subject.top_rate).to include(hotel1)
    end
  end
end
