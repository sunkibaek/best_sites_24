require 'rails_helper'

RSpec.feature "UsersSeeIndividualSitePages", type: :feature do
  let!(:site) do
    create :site, title: 'Test Title of Site', tags: 'test_tag, sample_tag'
  end

  scenario 'click on image to see individual site page' do
    visit '/'

    within '.bs-site-thumbnail:first-of-type' do
      find('a').click
    end

    expect(page).to have_css :h1, text: 'Test Title of Site'
  end

  scenario 'visit individual site page vi url to see details' do
    visit "/sites/#{site.id}"

    expect(page).to have_css :h1, text: 'Test Title of Site'
    expect(page).to have_css :span, text: 'test_tag'
    expect(page).to have_css :span, text: 'sample_tag'

    find('img[src]')
  end
end

