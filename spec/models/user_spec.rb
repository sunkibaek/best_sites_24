require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
