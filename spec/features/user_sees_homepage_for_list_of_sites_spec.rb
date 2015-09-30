require 'rails_helper'

RSpec.feature "UsersSeeHomepageForListOfSites", type: :feature do
  before do
    30.times do
      create :site
    end
  end

  scenario 'see twelve site images at a time' do
    visit '/'

    within '.most-recent' do
      expect(page).to have_css('.bs-site-thumbnail img', count: 12)
    end

    click_link '2'

    within '.most-recent' do
      expect(page).to have_css('.bs-site-thumbnail img', count: 12)
    end

    click_link '3'

    within '.most-recent' do
      expect(page).to have_css('.bs-site-thumbnail img', count: 6)
    end
  end

  scenario 'click on link to directly go to the site' do
    visit '/'

    within '.most-recent .col-lg-3:last-of-type .bs-site-thumbnail' do
      find("a:first-of-type").click
    end
  end
end
