require 'rails_helper'

RSpec.feature "UsersSeeHomepageForListOfSites", type: :feature do
  before do
    30.times do
      create :site
    end
  end

  scenario 'see twelve site images at a time' do
    visit '/'

    expect(page).to have_css('.bs-site-thumbnail img', count: 12)

    click_link '2'

    expect(page).to have_css('.bs-site-thumbnail img', count: 12)

    click_link '3'

    expect(page).to have_css('.bs-site-thumbnail img', count: 6)
  end
end
