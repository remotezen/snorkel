require 'spec_helper'

describe "UserPages" do

  subject {page}
  describe "signup page" do
    before {visit signup_path}
    it { should have_selector('h3', text: 'Sign up') }
    it { should have_title( full_title('Sign up') ) }
  end
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end
  
  describe "signup page" do
    before { visit signup_path}
    content = 'Sign up'
    let(:submit) {"Create my account"}
    it { should have_content(content) }
    it { should have_title(full_title(content)) }

    describe "with invalid information" do
      it "should not create a user" do
        expect {  click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before { click_button submit }
        it { should have_title('Sign up')}
        it { should have_content('error')}

      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        #valid_signin(user)
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in" 
      end
      it "should create user" do
        expect { click_button "Create my account" }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let (:user) {User.find_by(email: 'user@example.com')}
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success',
                                text: 'Welcome') }

      end
    end

  end
  describe "edit" do
    let(:user){ FactoryGirl.create(:user) }
    before{ visit edit_user_path(user) }
    describe "page" do
      it { should have_content("update your profile") }
      it {should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails')}

    end
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "New Email" }
      before do
        fill_in "Name",     with: new_name
        fill_in "Email",    with: new_email
        fill_in "Password",  with: user.password
        fill_in "Confirm Password", with: user.password
      end
      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') } 
      it { should have_link('Sign out', signout_path) }
      specify{ expect(user.reload.name).to eq new_name }
      specify{ expect(user.reload.email).to eq new_email }
    end
  end
end