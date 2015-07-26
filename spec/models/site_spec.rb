require 'rails_helper'

RSpec.describe Site, type: :model do
  subject(:site) do
    build :site,
      url: 'https://google.com',
      tags: 'test_tag, sample_tag'
  end

  describe '#tags_in_text' do
    it 'should return joined text of tags' do
      expect(site.tags).to eq ['test_tag', 'sample_tag']
      expect(site.tags_in_text).to eq 'test_tag, sample_tag'
    end
  end
end

