require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SiteHelper. For example:
#
# describe SiteHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SiteHelper, type: :helper do
  describe 'tag_label' do
    it 'returns html tags with tag' do
      tag = 'modern'

      expect(helper.tag_label(tag)).to eq '<span class="label label-default">' \
        '<a href="/tags/modern"><span class="fa fa-tag"></span>modern' \
        '</a></span>'
    end
  end
end
