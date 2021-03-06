require 'rails_helper'

RSpec.feature "AdminPostsNewSites", type: :feature do
  let(:user_admin) { create :user_admin }

  before do
    stub_request(:any, 'edition.cnn.com')
      .to_return(body: '<!DOCTYPE html><html><head><title>' \
        'Breaking News, U.S., World, Weather, Entertainment & Video' \
        ' News - CNN.com</title></head><body>CNN</body></html>')

    sign_in user_admin
  end

  scenario 'posts new site' do
    visit 'sites/new'

    fill_in 'Url', with: 'http://edition.cnn.com'
    fill_in 'Tags', with: 'tile, white, news'
    attach_file 'Screenshot', 'spec/support/assets/edition_cnn_com.png'

    click_button 'Save'

    have_content 'Site has been successfully created.'

    have_css :h1, 'Breaking News, U.S., World, Weather, Entertainment & Video' \
      ' News - CNN.com'
    have_css :span, 'tile'
    have_css :span, 'white'
    have_css :span, 'news'

    within '.bs-full-length-preview' do
      find 'a[title="Go to http://edition.cnn.com"]'
      find 'img[src]'
    end
  end
end
