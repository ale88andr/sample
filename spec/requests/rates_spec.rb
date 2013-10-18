require "spec_helper"

describe "Rates" do

  subject {page}

  describe "view rate" do
    let!(:rated_user) {FactoryGirl.create(:user)}
    let!(:user) {FactoryGirl.create(:user)}
    let!(:hotel) {FactoryGirl.create(:hotel, user_id: user.id)}
    let!(:rate) {FactoryGirl.create(:rate, user_id: rated_user.id, hotel_id: hotel.id)}

    before :each do
      visit new_user_session_path
      within('#new_user') do
        fill_in "user[name]", with: user.name
        fill_in "user[password]", with: user.password
        click_button "Sign in"
      end
    end

    context "on hotel page" do
      before {visit hotel_path(hotel)}

      it "show hotel rate" do
        expect(subject).to have_selector 'div.badge.badge-important', text: rate.rate
      end

      it "show hotel rate votes" do
        expect(subject).to have_selector 'div.badge.badge-important', text: hotel.rates.count
      end

      it "render rate form" do
        expect(subject).to have_selector 'form#new_rate'
      end

      it "show rate button" do
        within('#new_rate') do
          expect(subject).to have_button("Rate hotel")
        end
      end
    end

    context "adding vote" do
      let(:new_rate) {FactoryGirl.attributes_for(:rate, rate: "5")}
      before {visit hotel_path(hotel)}

      context "with text" do
        before :each do
          within('#new_rate') do
            select new_rate[:rate], from: rate[rate] 
            click_button "Rate hotel"
          end
        end

        it "show hotel rate" do
          expect(subject).to have_selector 'div.badge.badge-important', text: hotel.rates.sum(:rate).fdiv(hotel.rates.count)
        end

        it {should have_selector 'div.badge', text: hotel.rates.count}
        
        it "should skip rate form" do
          expect(subject).not_to have_selector 'form#new_rate'
        end

        it "should skip rate button" do
          expect(subject).not_to have_button("Rate hotel")
        end
      end
    end
  end
end
