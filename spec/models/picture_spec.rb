require 'rails_helper'

describe Picture do
  describe "associations" do
    it { is_expected.to belong_to :monument }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :monument    }
    it { is_expected.to validate_presence_of :name        }
    it { is_expected.to validate_presence_of :description }
  end
end
