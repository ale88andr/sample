require 'spec_helper'

describe CommentsController do
  before {sign_in(FactoryGirl.create(:user))}

  describe "POST #create" do
    let(:hotel) {FactoryGirl.create(:hotel)}

    context ".create_hotel_comment_by_user save comment" do
      it "saves coment to database" do
        expect{post :create, hotel_id: hotel, comment: FactoryGirl.attributes_for(:comment)}.to change(Comment, :count).by(1)
      end

      it "redirect to hotel after save" do
        post :create, hotel_id: hotel, comment: FactoryGirl.attributes_for(:comment)
        expect(response).to redirect_to hotel_path(hotel)
      end

      it "with notice" do
        post :create, hotel_id: hotel, comment: FactoryGirl.attributes_for(:comment)
        expect(flash[:notice]).to eq('comment added')
      end
    end

    context ".create_hotel_comment_by_user save comment" do
      it "not saves coment to database" do
        expect{post :create, hotel_id: hotel, comment: FactoryGirl.attributes_for(:comment, text: nil)}.not_to change(Comment, :count)
      end

      it "redirect to hotel break" do
        post :create, hotel_id: hotel, comment: FactoryGirl.attributes_for(:comment, text: nil)
        expect(response).to redirect_to hotel_path(hotel)
      end

      it "with notice" do
        post :create, hotel_id: hotel, comment: FactoryGirl.attributes_for(:comment, text:nil)
        expect(flash[:notice]).to eq('comment not added')
      end
    end
  end
end