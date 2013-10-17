require 'spec_helper'

describe HotelsController do

  before {sign_in(FactoryGirl.create(:user))}

  describe "GET #index" do
    let(:hotel) {FactoryGirl.create(:hotel)}
    before { get :index }

    it "render :index template" do
      expect(response).to render_template file: :index
    end

    it "assigns @hotels to :index" do
      expect(assigns[:hotels]).to eq [hotel]
    end
  end

  describe "GET #show" do
    let(:hotel) {FactoryGirl.create(:hotel)}
    before { get :show, id: hotel }

    it "render :show template" do
      expect(response).to render_template file: :show
    end

    it "assigns @hotel to :show" do
      expect(assigns[:hotel]).to eq hotel
    end
  end

  describe "GET #new" do
    let!(:hotel) {mock_model(Hotel).as_new_record}
    before do
      Hotel.stub(:new).and_return(hotel)
      get :new
    end

    it "render :new template" do
      expect(response).to render_template :new
    end

    it "assigns @hotel to :new" do
      expect(assigns[:hotel]).to eq hotel
    end
  end

  describe "POST #create" do
    context "return true" do
      it "saves hotel in database" do
        expect{ post :create, hotel: FactoryGirl.attributes_for(:hotel) }.to change(Hotel, :count).by(1)
      end

      it "redirects to hotels path" do
        post :create, hotel: FactoryGirl.attributes_for(:hotel)
        expect(response).to redirect_to hotels_path
      end
    end

    context "return false" do
      it "not saves hotel in database" do
        expect{ post :create, hotel: FactoryGirl.attributes_for(:hotel, title: nil) }.not_to change(Hotel, :count)
      end

      it "redirects to :new" do
        post :create, hotel: FactoryGirl.attributes_for(:hotel, title: nil)
        expect(response).to render_template :new
      end
    end
  end

end
