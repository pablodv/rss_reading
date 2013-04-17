require 'spec_helper'

describe User do
  describe "Associations" do
    it { should have_many(:authentications) }
    it { should have_many(:channels) }
    it { should have_many(:users_articles) }
    it { should have_many(:favorites).through(:users_articles) }
  end

  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should ensure_length_of(:first_name).is_at_most(50) }
    it { should ensure_length_of(:last_name).is_at_most(50) }
    it { should ensure_length_of(:username).is_at_most(50) }
  end

  describe "Avatar" do
    let(:user){ User.new }

    context "Paperclip behavior" do
      it "responds to avatar attachment" do
        user.should respond_to(:avatar)
      end

      it "has a paperclip filed named Avatar" do
        user.avatar.should be_an_instance_of(Paperclip::Attachment)
      end
    end

    context "validations" do
      it { should have_attached_file(:avatar) }
      it { should validate_attachment_content_type(:avatar).
            allowing('image/png', 'image/jpeg').
            rejecting('text/plain', 'text/xml')
      }
    end
  end

  let(:auth){ OmniAuth::AuthHash.new(
    provider: 'twitter',
    uid: '123456',
    info: { email: "twitter@rss.com",
            first_name: "Pepe",
            last_name: "Hogo",
            username: "pepe_hongo" })
  }

  describe "Class Methods" do
    describe "finding or createing with omniauth" do
      context "with existing authentication" do
        before do
          @user = FactoryGirl.create(:user)
          FactoryGirl.create(:authentication, user: @user)
        end

        it "returns an authentication user instance" do
          user = User.find_or_create_with_omniauth(auth)
          user.should == @user
        end
      end

      context "without existing authentication" do
        before do
          @user = FactoryGirl.create(:user, email: "twitter@rss.com")
        end

        it "returns an existing user" do
          user = User.find_or_create_with_omniauth(auth)
          user.should == @user
        end
      end

      context "without existing authentication and user" do
        it "returns a new user instance" do
          expect {
            User.find_or_create_with_omniauth(auth)
          }.to change(User, :count).by(1)
        end
      end
    end

    describe "building with omniauth" do
      it "returns a new user instance" do
        user = User.new_with_omniauth(auth)
        user.should be_an_instance_of(User)
      end
    end
  end
end
