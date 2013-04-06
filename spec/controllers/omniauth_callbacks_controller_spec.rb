require 'spec_helper'

describe Users::OmniauthCallbacksController do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  describe "Twitter authorization" do
    before do
      @user = stub_model(User, id: "1")

      User.stub!(:find_or_create_with_omniauth).and_return(@user)
      @user.stub!(:persisted?)
    end

    it "finds or creates the request user" do
      User.should_receive(:find_or_create_with_omniauth).and_return(@user)
      get :twitter
      assigns(:user).should == @user
    end

    context "with persistence user" do
      it "signs in and responds with redirect" do
        @user.should_receive(:persisted?).and_return(true)
        get :twitter
        sign_in @user
        flash[:notice].should eql("Successfully authenticated from Twitter account.")
        response.should be_redirect
      end
    end

    context "without persistence user" do
      it "responds with redirect" do 
        @user.should_receive(:persisted?).and_return(false)
        get :twitter
        response.should be_redirect
      end
    end
  end
end
