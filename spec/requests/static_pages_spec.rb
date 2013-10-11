require 'spec_helper'

describe "StaticPages" do
  subject {page}
  
  describe "Home Page" do
    let(:heading) {'Snorkel'}
    let(:page_title) {''}
    before do 
      visit root_path
    end
    it "should have the right links on the layout" do
      click_link 'About' 
      expect(page).to have_title(full_title('About us'))
      click_link 'Help' 
      expect(page).to have_title(full_title('Help') )
      click_link 'Home' 
      expect(page).to have_title(full_title(''))
    end
    describe "for signed in users" do 
      before do 
        visit root_path
        sign_in user
      end
      
      let(:user) { FactoryGirl.create(:user) }
      before do 
        FactoryGirl.create(:micropost, user: user,
                          content: "Lorem ipsum")

        FactoryGirl.create(:micropost, user: user,
                          content: "Dolor sit amet")
      end
      it "should render the user's feed" do 
        user.feed.each do |i|
         expect(page).to have_selector("li##{ i.id }", text: i.content)
        end
      end
      describe "pagination" do 
        before(:all) { 100.times { FactoryGirl.create(:micropost, 
                                                      user: user, content: "Foo") } }
        it { should have_selector('div.pagination'); save_and_open_page }
        after(:all) { Micropost.delete_all }
        after(:all){ User.delete_all }
    end

  end
  describe "Help page" do
    before {visit help_path}
    let(:heading) {'Help'}
    let(:page_title) {'Help'}
   end
  
  describe "About page" do
    before { about_path }
    let(:heading) {'Help'}
    let(:page_title) { 'Help' }
   end
  
  describe "Contact page" do
    before { contact_path }
    let(:heading) { 'Help' } 
    let(:page_title) { 'Help' }
  end
end
end
