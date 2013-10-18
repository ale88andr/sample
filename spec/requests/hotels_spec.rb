require "spec_helper"

describe "Hotels" do

  subject {page}

  describe "only registered user can access to Hotels" do
    before { visit root_path }

    it { expect(current_path).to eq new_user_session_path }
    it { expect(page).not_to have_link "Add hotel", href: new_hotel_path }
    it { expect(page).to have_selector('div', text: "Message: You need to sign in or sign up before continuing.")}
  end

  describe "manage hotels" do
    let!(:user) {FactoryGirl.create(:user)}

    before :each do
      visit new_user_session_path
      within('#new_user') do
        fill_in "user[name]", with: user.name
        fill_in "user[password]", with: user.password

        click_button "Sign in"
      end
    end

    describe "listing hotels" do
      it ":index should be render" do
        get '/hotels'
        expect(response).to render_template :index
      end

      it { should have_link "Add hotel", href: new_hotel_path }
      it { should have_selector "h1", text: "Welcome to hotels catalogue" }

      it { should have_selector "div", text: "Top 5 raiting hotels :" }

      it { should have_link "Add your hotel", href: new_hotel_path }

      it { expect(page).to have_link "Logout (#{user.name})", destroy_user_session_path }

      context "when database empty" do
        it { expect(Hotel.find(:all).size).to eq 0 }

        it "index page should notify" do
          expect(page).to have_selector 'p', 'There are no hotels added yet'
        end
      end

      context "when any hotels in database" do
        let!(:hotel1) {FactoryGirl.create(:hotel)}
        let!(:hotel2) {FactoryGirl.create(:hotel)}

        it { expect(Hotel.find(:all).size).to eq 2 }

        before { visit hotels_path }

        context ":index template render" do

          it "links to view hotel" do
            expect(page).to have_link 'View', href: hotel_path(hotel1)
            expect(page).to have_link 'View', href: hotel_path(hotel2)
          end

          it "headers with hotels name" do
            expect(page).to have_selector 'h3', text: hotel1.title
            expect(page).to have_selector 'h3', text: hotel2.title
          end
        end
      end
    end

    describe "view single hotel" do
      let!(:hotel) {FactoryGirl.create(:hotel, user_id: user.id)}
      let!(:comment) {FactoryGirl.create(:comment, user_id: user.id, hotel_id: hotel.id)}

      before { visit hotel_path(hotel) }

      it "show full hotel info" do
        expect(page).to have_selector 'b', text: hotel.title
      end

      it "show hotel rate form selctor" do
        within('#new_rate') do
          expect(page).to have_select "rate[rate]"
        end
      end

      it "show hotel rate commit button" do
        within('#new_rate') do
          expect(page).to have_button "Rate hotel"
        end
      end

      it "show comment form" do
        expect(page).to have_selector 'form#new_comment'
      end

      it "show comment text" do
        expect(page).to have_selector 'p', text: comment.text
      end

      it "show comment author" do
        expect(page).to have_selector 'div.label', text: comment.user.name
      end

      it "show add comment button" do
        within('#new_comment') do
          expect(page).to have_button("Add comment")
        end
      end
    end

    describe "add new hotel" do
      before {visit new_hotel_path}

      context "render" do
        it "text header" do
          expect(page).to have_selector 'h1', text: "Adding new hotel"
        end

        it "new hotel form" do
          within("#new_hotel") do
            expect(page).to have_field "hotel[title]", type: 'text'
            expect(page).to have_checked_field "hotel[breakfast]"
            expect(page).to have_field "hotel[price_for_room]", type: 'number'
            expect(page).to have_field "hotel[address][country]", type: 'text'
            expect(page).to have_field "hotel[address][state]", type: 'text'
            expect(page).to have_field "hotel[address][city]", type: 'text'
            expect(page).to have_field "hotel[address][street]", type: 'text'

            expect(page).to have_button "Add new hotel"
          end
        end
      end

      context "fill form" do
        let(:new_hotel) {FactoryGirl.attributes_for(:hotel)}

        before :each do
          within('#new_hotel') do
            fill_in "hotel[title]", with: new_hotel[:title]
            uncheck "hotel[breakfast]"
            fill_in "hotel[room_description]", with: new_hotel[:room_description]
            fill_in "hotel[price_for_room]", with: new_hotel[:price_for_room]
            fill_in "hotel[address][street]", with: 'street'
            fill_in "hotel[address][city]", with: 'city'
            fill_in "hotel[address][country]", with: 'country'
            fill_in "hotel[address][state]", with: 'state'

            click_button "Add new hotel"
          end
        end

        it "redirect after add" do
          expect(current_path).to eq hotels_path
        end

        it "hotel should be added" do
          expect(page).to have_selector 'h3', text: new_hotel[:title]
        end
      end
    end

  end

end
