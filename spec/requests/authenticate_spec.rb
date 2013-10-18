require "spec_helper"

describe "Auth" do

  subject {page}

  shared_examples_for "access home page" do
    it { expect(current_path).to eq root_path }
    it { expect(page).to have_link "Hotels", href: root_path }
    it { expect(page).to have_link "Add hotel", href: new_hotel_path }
  end

  describe "visit sign in page" do
    let(:user) {FactoryGirl.create(:user)}

    before {visit new_user_session_path}

    it {expect(current_path).to eq "/users/sign_in"}

    it "render sign_in form" do
      expect(page).to have_css 'form#new_user'
    end

    it {expect(have_content "Sign in :").to be}

    it "form contains fields" do
      within('#new_user') do
        expect(page).to have_field "user[name]", type: 'text'
        expect(page).to have_field "user[password]", type: 'password'

        expect(page).to have_button "Sign in"
      end
    end

    context "contains devise shared links" do
      it { expect(page).to have_link "Sign up", href: new_user_registration_path}
      it { expect(page).to have_link "Forgot your password?", href: new_user_password_path}
    end

    context "sign in" do

      it_behaves_like "access home page" do
        before :each do
          within('#new_user') do
            fill_in "user[name]", with: user.name
            fill_in "user[password]", with: user.password

            click_button "Sign in"
          end
        end

        it { expect(page).to have_selector('div', text: "Message: Signed in successfully.")}
        it { expect(page).to have_link "Edit registration", href: edit_user_registration_path }
        it { expect(page).to have_link "Logout (#{user.name})", destroy_user_session_path }
      end
      
    end

  end

  describe "visit sign in page" do
    let(:sign_up_user) {FactoryGirl.attributes_for(:user)}

    before {visit new_user_registration_path}

    it {expect(current_path).to eq "/users/sign_up"}

    it {expect(User.find_by_name(sign_up_user[:name])).to be_nil}

    context "render sign_up form" do
      it { have_css 'form#new_user' }

      it {have_content "Sign Up :"}

      it "sign up form contains fields" do
        within('#new_user') do
          have_field "user[name]", type: 'text'
          have_field "user[email]", type: 'email'
          have_field "user[password]", type: 'password'
          have_field "user[password_confirmation]", type: 'password'

          have_button "Sign in"
        end
      end
    end

    context "contains devise shared links" do
      it { expect(page).to have_link "Sign in", href: new_user_session_path}
    end

    context "sign up" do

      it_behaves_like "access home page" do
        before :each do
          within('#new_user') do
            fill_in "user[name]", with: sign_up_user[:name]
            fill_in "user[email]", with: sign_up_user[:email]
            fill_in "user[password]", with: sign_up_user[:password]
            fill_in "user[password_confirmation]", with: sign_up_user[:password]

            click_button "Sign up"
          end
        end

        it { expect(page).to have_selector('div', text: "Message: Welcome! You have signed up successfully.")}
        it { expect(page).to have_link "Edit registration", href: edit_user_registration_path }
        it { expect(page).to have_link "Logout (#{sign_up_user[:name]})", destroy_user_session_path }
      end
    end

  end

  describe "Logout" do
    let!(:user) {FactoryGirl.create(:user)}

    before { visit new_user_session_path }

    context "Login / Logout" do

      it_behaves_like "access home page" do
        before :each do
          within('#new_user') do
            fill_in "user[name]", with: user.name
            fill_in "user[password]", with: user.password

            click_button "Sign in"
          end
        end

        it { expect(page).to have_selector('div', text: "Message: Signed in successfully.")}
        it { expect(page).to have_link "Edit registration", href: edit_user_registration_path }
        it { expect(page).to have_link "Logout (#{user.name})", destroy_user_session_path }

        context "Logout" do
          before { click_link "Logout (#{user.name})" }
          
          it { expect(current_path).to eq new_user_session_path }
          it { expect(page).to have_selector('div', text: "Message: You need to sign in or sign up before continuing.") }
        end
      end
      
    end

  end

end
