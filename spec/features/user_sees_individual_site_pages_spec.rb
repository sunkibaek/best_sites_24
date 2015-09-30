require 'rails_helper'

RSpec.feature "UsersSeeIndividualSitePages", type: :feature do
  let!(:site) do
    create :site, title: 'Test Title of Site', tags: 'test_tag, sample_tag',
      url: 'http://www.test-url.com'
  end

  let!(:another_site) do
    create :site, title: 'Another Test Title of Site', tags: 'another_tag'
  end

  scenario 'click on image to see individual site page' do
    visit '/'

    within '.most-recent .col-lg-3:last-of-type .bs-site-thumbnail' do
      find('a[title="Test Title of Site"]').click
    end

    expect(page).to have_css :h1, text: 'Test Title of Site'
  end

  scenario 'visit individual site page via url to see details' do
    visit "/sites/#{site.id}"

    expect(page).to have_css :h1, text: 'Test Title of Site'
    expect(page).to have_css :span, text: 'test_tag'
    expect(page).to have_css :span, text: 'sample_tag'

    find('.bs-full-length-preview img[src]')
  end

  scenario 'visit individual site page and filter contents via tags' do
    visit "/sites/#{site.id}"

    click_link 'test_tag'

    # refactor to find sites only with the tag
    #find('a[title="Test Title of Site"]')

    within '.most-recent' do
      expect(page).to have_css '.bs-site-thumbnail a img', count: 1
    end
  end

  scenario 'visit individual site page via url slug' do
    visit '/sites/' + site.url_slug

    expect(page).to have_css :h1, text: 'Test Title of Site'
  end
end
