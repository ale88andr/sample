require 'spec_helper'

describe RatesController do
  before {sign_in(FactoryGirl.create(:user))}

  describe "POST #create" do
    let(:hotel) {FactoryGirl.create(:hotel)}

    context ".add_vote save rate" do
      it "saves rate to database" do
        expect{post :create, hotel_id: hotel, rate: FactoryGirl.attributes_for(:rate)}.to change(Rate, :count).by(1)
      end

      it "redirect to hotel after save" do
        post :create, hotel_id: hotel, rate: FactoryGirl.attributes_for(:rate)
        expect(response).to redirect_to hotel_path(hotel)
      end

      it "with notice" do
        post :create, hotel_id: hotel, rate: FactoryGirl.attributes_for(:rate)
        expect(flash[:notice]).to eq('Your vote added')
      end
    end

    context ".add_vote not save double rate" do
      before {FactoryGirl.create(:rate)}

      it "not saves double user rate to database" do
        expect{post :create, hotel_id: hotel, rate: FactoryGirl.attributes_for(:rate)}.not_to change(Comment, :count)
      end
    end
  end
end
