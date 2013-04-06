require 'spec_helper'

describe Authentication do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
  end

  describe "Class Methods" do
    let(:auth){ OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456') }

    describe "finding with omniauth" do
      before :each do
        @authentication = FactoryGirl.create(:authentication)
      end

      it "returns an existing authentication instance" do
        authentication = Authentication.find_with_omniauth(auth)
        authentication.should == authentication
      end
    end

    describe "createing with omniauth" do
      it "returns an new authentication instance" do
        expect {
          Authentication.create_with_omniauth(auth)
        }.to change(Authentication, :count).by(1)
      end
    end
  end
end
