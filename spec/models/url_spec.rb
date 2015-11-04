require 'rails_helper'

RSpec.describe Url, type: :model do
  it "has a valid factory" do
    expect(build(:url)).to be_valid
  end

  describe "validations" do
    it "is invalid when an original url is not provided" do
      expect(build(:url, original: nil)).to_not be_valid
    end

    it "is valid when an original url is provided and vanity string is not provided" do
      expect(build(:url, shortened: nil)).to be_valid
    end

    it "is valid when an original url is provided and vanity string is provided" do
      expect(build(:url)).to be_valid
    end
  end
end
