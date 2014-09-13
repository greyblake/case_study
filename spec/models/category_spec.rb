require 'rails_helper'

describe Category do
  describe "associations" do
    it { is_expected.to belong_to :user }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :name }
  end
end