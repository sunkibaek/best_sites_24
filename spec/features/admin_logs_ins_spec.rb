require 'rails_helper'

RSpec.feature "AdminLogsIns", type: :feature do
  before do
    create :user_admin, email: 'admin@example.com',
                        password_digest: 'TestPassword'
  end

  scenario 'visits log in page' do
    visit '/login'

    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'TestPassword'

    click_button 'Log In'

    expect(page).to have_content 'Welcome back!'
  end
end

