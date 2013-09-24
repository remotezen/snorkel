  def sign_in(user)
    fill_in "Email", with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
  def full_user
    fill_in "Name",         with: "ExampleUser"
    fill_in "Email",        with: "user@example.com"
    fill_in "Password",     with: "foobar"
    fill_in "Confirmation", with:"foobar"
    
  end
=begin  
RSpec.configure do |config|
  config.include UserUtils, :type => :feature
end
=end
