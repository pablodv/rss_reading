require 'spec_helper'

describe Channel do
  describe "Associations" do
    it { should belong_to :user }
    it { should have_many :articles }
  end

  describe "Validations" do
    describe "Mandatory" do
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :url }
      it { should validate_presence_of :name }
    end

    describe "Format" do
      before do
        @channel = Channel.new
      end

      it "requires a valid url to be valid" do
        @channel.url = "foo_url"
        @channel.should_not be_valid
        @channel.should have_at_least(1).errors_on(:url)
      end
    end

    describe "Uniqueness" do
      it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    end
  end

  describe "Callbacks" do
    describe "Before Validation" do
      before do
        raw_response_file = File.open(File.join(Rails.root, "spec/support/railscasts.xml"))
        stub_request(:get, "http://feeds.feedburner.com/railscasts").to_return(body: raw_response_file)
      end

      describe "fetch and validate feet" do
        let(:channel){ FactoryGirl.build(:channel, name: nil, url: "http://feeds.feedburner.com/railscasts") }

        context "with valid url" do
          it "does not take the channel title" do
            channel.send(:fetch_and_validate_feed)
            channel.name.should_not be_nil
          end

          it "takes the channel title" do
            lambda {
              channel.save
            }.should change(channel, :name).from(nil).to("RailsCasts")
          end
        end

        context "without valid url" do
          let(:channel){ FactoryGirl.build(:channel, name: nil, url: "http://foo.feed") }

          it "does not take the channel title" do
            channel.send(:fetch_and_validate_feed)
            channel.name.should be_nil
          end

          it "responds with an error" do
            channel.send(:fetch_and_validate_feed)
            channel.should_not be_valid
            channel.should have_at_least(1).errors_on(:url)
          end
        end

        it "does called only by a new channel" do
          channel.should_receive(:fetch_and_validate_feed)
          channel.save
        end

        it "does not called by a exiting channel" do
          channel = FactoryGirl.create(:channel, name: nil, url: "http://feeds.feedburner.com/railscasts")
          channel.should_not_receive(:fetch_and_validate_feed)
          channel.save
        end
      end
    end
  end
end
