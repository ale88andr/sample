require "spec_helper"

describe "Comments" do

  subject {page}

  describe "view comments" do
    let!(:user) {FactoryGirl.create(:user)}
    let!(:hotel) {FactoryGirl.create(:hotel, user_id: user.id)}
    let!(:comment) {FactoryGirl.create(:comment, user_id: user.id, hotel_id: hotel.id)}

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

      it "show comment text" do
        expect(subject).to have_selector 'p', text: comment.text
      end

      it "show comment author" do
        expect(subject).to have_selector 'div.label', text: comment.user.name
      end

      it "show comment form" do
        expect(subject).to have_selector 'form#new_comment'
      end

      it "show add comment button" do
        within('#new_comment') do
          expect(subject).to have_button("Add comment")
        end
      end
    end

    context "adding comment" do
      let(:new_comment) {FactoryGirl.attributes_for(:comment)}
      before {visit hotel_path(hotel)}

      context "with text" do
        before :each do
          within('#new_comment') do
            fill_in 'comment[text]', with: new_comment[:text]
            click_button "Add comment"
          end
        end

        it {should have_selector 'div.badge', text: Comment.count}
        it {should have_selector 'p', text: new_comment[:text]}

      end

      it "with empty text" do
        click_button "Add comment"
        expect(page).to have_selector 'div.alert', text: 'Message: comment not added'
      end
    end

  end

end
