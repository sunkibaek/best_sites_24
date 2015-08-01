require 'rails_helper'

RSpec.feature "UsersSeeHomepageForListOfSites", type: :feature do
  before do
    30.times do
      create :site, url: test_url
    end
  end
  let(:test_url) { 'http://www.test-url.com' }

  scenario 'see twelve site images at a time' do
    visit '/'

    expect(page).to have_css('.bs-site-thumbnail img', count: 12)

    click_link '2'

    expect(page).to have_css('.bs-site-thumbnail img', count: 12)

    click_link '3'

    expect(page).to have_css('.bs-site-thumbnail img', count: 6)
  end

  scenario 'click on link to directly go to the site' do
    visit '/'

    within '.col-lg-3:first-of-type .bs-site-thumbnail' do
      find("a[title=\"Go to #{test_url}\"]").click
    end
  end
end
