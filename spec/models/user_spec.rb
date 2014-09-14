require 'rails_helper'

describe User do
  describe 'associations' do
    it { is_expected.to have_many :categories  }
    it { is_expected.to have_many :collections }
    it { is_expected.to have_many :monuments   }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :login    }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_uniqueness_of :login }
    it { is_expected.to validate_confirmation_of :password }
    it { is_expected.to ensure_length_of(:password).is_at_least(8) }
    it { is_expected.to ensure_length_of(:password).is_at_most(32) }
  end

  it "sets password_digest on creation" do
    user = User.create!(login: "mikki", password: "123455678")
    expect(user.password_digest).not_to be_empty
  end
end
