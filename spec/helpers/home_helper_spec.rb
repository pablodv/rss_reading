require 'spec_helper'

describe HomeHelper do
   describe "resource name" do
    it "returns devise resource name" do
      helper.resource_name.should == :user
    end
  end

  describe "resource" do
    it "returns an instance of devise resource" do
      helper.resource.should be_an_instance_of(User)
    end
  end

  describe "devise mapping" do
    it "returns devise resource map" do
      helper.devise_mapping.should == Devise.mappings[:user]
    end
  end
end
