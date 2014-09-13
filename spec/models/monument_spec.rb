require 'rails_helper'

describe Monument do
  describe "associations" do
    it { is_expected.to belong_to :category   }
    it { is_expected.to belong_to :collection }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :category    }
    it { is_expected.to validate_presence_of :collection  }
    it { is_expected.to validate_presence_of :name        }
    it { is_expected.to validate_presence_of :description }
  end
end
