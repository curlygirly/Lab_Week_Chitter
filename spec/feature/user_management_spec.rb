require 'capybara/rspec'
require './app/server'
require_relative 'helpers/sessions'

include SessionHelpers

feature 'User signs up' do

 scenario 'as a new user visiting the site' do
    visit '/'
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, Bob')
    expect(User.first.name).to eq('Bob')
  end

  scenario ' with a password that does not match' do
    expect { sign_up(password: 'pass', password_confirmation: 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/user')
    expect(page).to have_content('Sorry, your passwords do not match')
  end

#  xscenario ' cannot sign up with same username'

end

feature 'As a registered user' do

  before(:each) do
    User.create(name: 'Bob',
                username: 'bobby',
                email: 'bob@bob.com',
                password: 'bob',
                password_confirmation: 'bob')
  end

  scenario 'can sign in' do
    visit '/'
    expect(page).not_to have_content('Welcome, Bob')
    sign_in
    expect(page).to have_content('Welcome, Bob')
  end

  scenario "can sign out" do
    visit '/'
    sign_in
    expect(page).to have_content('Welcome, Bob')
    sign_out
    expect(page).not_to have_content('Welcome, Bob')
  end
end
