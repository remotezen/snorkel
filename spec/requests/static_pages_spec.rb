require 'spec_helper'

describe "StaticPages" do
  
  subject { page }
  share_examples_for "all static pages" do
    it { should have_selector('h6', text: heading) }
    it { should have_title(full_title(page_title) ) }
  end

  
  describe "Home Page" do
      let(:heading) {'Snorkel'}
      let(:page_title) {''}
      before { visit root_path }
      it "should have the right links on the layout" do
        click_link 'About' 
        expect(page).to have_title(full_title('About us'))
        click_link 'Help' 
        expect(page).to have_title(full_title('Help') )
        click_link 'Home' 
        expect(page).to have_title(full_title(''))
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
