module SessionHelpers

def sign_up(email = 'bob@bob@bob',
              name = 'Bob',
              username = 'bobby',
              password = 'bob',
              password_confirmation = 'bob')
  visit '/user/new'
  fill_in :email, with: email
  fill_in :name, with: name
  fill_in :username, with: username
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
  end

 def sign_in(email = 'bob@bob.com',
              username = 'bobby',
              password = 'bob')
  visit '/session/new'
  fill_in :email, with: email
  fill_in :username, with: username
  fill_in :password, with: password
  click_button 'Sign in'
  end

  def sign_out()
    visit '/'
    click_button 'Sign out'
  end

  def add_peep(message)
    visit '/'
    fill_in :message, with: message
    click_button "Peep"
  end
end