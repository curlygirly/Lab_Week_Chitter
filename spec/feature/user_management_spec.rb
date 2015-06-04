require 'capybara/rspec'
require './app/server'

feature 'User signs up' do

 scenario 'as a new user visiting the site' do
    visit '/'
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, Bob')
    expect(user.first.name).to eq('Bob')
  end

  def sign_up(email = 'bob@bob@bob',
              name = 'Bob',
              username = 'bobby',
              password = 'bob',
              password_confirmation = 'bob')
  visit '/users/new'
  fill_in :email, with: email
  fill_in :name, with: name
  fill_in :username, with: username
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
  end

end

