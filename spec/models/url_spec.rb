require 'rails_helper'
require 'yaml'

def load_yml path
  YAML.load File.read(File.expand_path(path))
end

valid_urls = load_yml('spec/factories/valid_urls.yml')
invalid_urls = load_yml('spec/factories/invalid_urls.yml')

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

    it "is invalid if the provided vanity string is not alphanumeric" do
      val = %w{sd+ *7 %sdsdfs #sfs# "" " "}
      val.each do |v|
        expect(build(:url, shortened: v)).to_not be_valid
      end
    end

    it "is valid if the provided vanity string is alphanumeric" do
      5.times do
        expect(build(:url, shortened: Faker::Lorem.word)).to be_valid
      end
    end

    it "is invalid if vanity string has already been used" do
      params = {original: "http://google.com", shortened: "val"}
      first_attempt = Url.create(params)
      second_attempt = Url.create(params)
      expect(second_attempt).not_to be_persisted
      expect(second_attempt.errors[:shortened]).to include("has already been taken")
    end

    describe "is invalid if the provided original url is invalid" do
      invalid_urls.each do |section, urls|
        describe section do
          urls.each do |invalid|
            it invalid do
              expect(build(:url, original: invalid)).not_to be_valid
            end
          end
        end
      end
    end

    describe "is valid if the provided original url is valid" do
      valid_urls.each do |section, urls|
        describe section do
          urls.each do |valid|
            it valid do
              expect(build(:url, original: valid)).to be_valid
            end
          end
        end
      end
    end
  end

  describe "#save_shortened" do
    it "updates the shortened column for urls saved without a vanity string" do
      url = create(:url, shortened: nil)
      expect(url.shortened).to_not be nil
      expect(url.shortened).to eq(url.id.to_s(32).reverse)
    end

    it "does not update the shortened for urls saved without a vanity string" do
      url = create(:url, shortened: "bingo")
      expect(url.shortened).to_not be nil
      expect(url.shortened).to_not eq(url.id.to_s(32).reverse)
      expect(url.shortened).to eq("bingo")
    end
  end

  describe "#create_shortened_url" do
    it "returns a reversed version of the conversion of the given number argument to string in base 32" do
      10.times do
        id = rand(1..100)
        expect(Url.new.create_shortened_url(id)).to eq(id.to_s(32).reverse)
      end
    end
  end

  describe "#save_this_visit" do
    let(:url) { create(:url, views: 0) }
    it "increments the value in the views column of the given url" do
      num = Faker::Number.between(1, 10)
      expect(url.views).to eq(0)
      num.times do
        url.save_this_visit
      end
      expect(url.views).to eq(num)
    end
  end

  describe "#popular" do
    before(:each) do
      5.times do
        create(:url)
      end
      @first = create(:url, views: 10000)
      @last = create(:url, views: 000)
    end
    after(:all) {Url.delete_all}

    it "lists the first 5 most viewed urls on the site if no argument is passed" do
      expect(Url.popular.size).to eq 5
      expect(Url.popular.last).not_to eq @last
      expect(Url.popular.first).to eq @first
    end

    it "returns the number of requested urls arranged by views" do
      urls = Url.popular(3)
      expect(urls.size).to eq 3
      expect(urls.first).to eq @first
      expect(urls.last).to_not eq @last
    end

    it "returns just the available urls if the provided argument is more than the urls in the db" do
      urls = Url.popular(100000000)
      expect(urls.size).to eq 7
      expect(urls.first).to eq @first
      expect(urls.last).to eq @last
    end
  end

  describe "#recent" do
    before(:each) do
      @last = create(:url)
      5.times do
        sleep(1)
        create(:url)
      end
      @first = create(:url)
    end
    after(:all) {Url.delete_all}

    it "lists the first 5 most viewed urls on the site if no argument is passed" do
      expect(Url.recent.size).to eq 5
      expect(Url.recent.last).not_to eq @last
      expect(Url.recent.first).to eq @first
    end

    it "returns the number of requested urls arranged by id desc" do
      urls = Url.recent(3)
      expect(urls.size).to eq 3
      expect(urls.first).to eq @first
      expect(urls.last).to_not eq @last
    end

    it "returns just the available urls arranged by id desc if the provided argument is more than the urls in the db" do
      urls = Url.recent(10000000)
      expect(urls.size).to eq 7
      expect(urls.first).to eq @first
      expect(urls.last).to eq @last
    end
  end

  describe "#get_url" do
    before(:each) do
      @url = Url.create(shortened: "go", original: "http://google.com")
    end
    after(:all) {Url.delete_all}

    it "returns the original link of the given url id" do
      expect(Url.get_url(1)).to eq @url
    end

    it "returns the url of the given shortened link" do
      expect(Url.get_url("go", :shortened)).to eq @url
    end

    it "returns the url of the given original url" do
      expect(Url.get_url("http://google.com", :original)).to eq @url
    end

    it "returns nil if the url is not found" do
      expect(Url.get_url("gog", :shortened)).to be_nil
      expect(Url.get_url("gog", :original)).to be_nil
      expect(Url.get_url("gog")).to be_nil
    end

    it "throws an error if called with wrong arguments" do
      expect {Url.get_url}.to raise_error(ArgumentError)
      expect {Url.get_url("one", "two", "three")}.to raise_error(ArgumentError)
    end
  end

  describe "#init_with" do
    it "initializes an object of the Url class with the given params" do
      url = Url.init_with(original: "http://google.com")
      expect(url).to be_a(Url)
      expect(url.new_record?).to be true
    end

    it "returns the existing record if the give params is already in the db" do
      url = create(:url, original: "http://google.com")
      url2 = Url.init_with(original: "http://google.com")
      expect(url2).to be_a(Url)
      expect(url2).to eq url
      expect(url2.new_record?).to be false
    end

    it "throws an error if called with wrong arguments" do
      expect {Url.get_url}.to raise_error(ArgumentError)
    end
  end

end
