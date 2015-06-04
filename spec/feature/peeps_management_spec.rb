require 'capybara/rspec'
require 'spec_helper'
require './app/server'
require_relative 'helpers/sessions'

include SessionHelpers

feature 'Peeps' do

  scenario 'can be posted' do
    sign_up
    visit '/'
    expect(page).not_to have_content("Hello world")
    add_peep("Hello world")
    expect(page).to have_content("Hello world")
  end

end