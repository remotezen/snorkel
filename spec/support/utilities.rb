include ApplicationHelper
def  full_title(page_title)
  base_title = "Snorkel"
  if page_title.empty?
    return base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def  valid_signin(user)
  fill_in "Password", with: user.password
  fill_in "Email", with: user.email
  click_button "Sign in"
end
RSpec::Matchers.define :have_error_message do |msg|
  match do |page|
    expect(page).to have_selector('div.alert.alert.error', text: msg)
  end
end
