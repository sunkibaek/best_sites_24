require 'rails_helper'

RSpec.describe Site, type: :model do
  subject(:site) do
    build :site,
      url: 'https://google.com',
      tags: 'test_tag, sample_tag'
  end

  describe '#tags=' do
    it 'should save input texts as tags array' do
    end
  end

  describe '#html_doc' do
    it 'should parse ' do
    end
  end

  describe '#fetch_html_doc' do
  end
end

