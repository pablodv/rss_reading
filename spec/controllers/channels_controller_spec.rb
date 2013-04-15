require 'spec_helper'

describe ChannelsController do
  login_user

  before do
    @channels = mock_model(Channel)
    @user     = mock_model(User)

    controller.stub!(:current_user).and_return(@user)
    @user.stub!(:channels).and_return(@channels)
  end

  describe "#index" do
    it "finds the current user channels" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:channels).and_return(@channels)
      get :index, user_id: 1
    end
    it "assigns the current channels to @channels" do
      get :index, user_id: 1
      assigns(:channels).should == @channels
    end
    it "renders the index template" do
      get :index, user_id: 1
      response.should render_template :index
    end
  end

  describe "#new" do
    before do
      @channels.stub!(:new).and_return(@channels)
    end

    it "builds a new channel instance" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:channels).and_return(@channels)
      @channels.should_receive(:new).and_return(@channels)
      get :new, user_id: 1
    end

    it "assigns the new instance channel to @channel" do
      get :new, user_id: 1
      assigns(:channel).should == @channels
    end

    it "renders the new template" do
      get :new, user_id: 1
      response.should render_template :new
    end
  end

  describe "#create" do
    before do
      @channels.stub!(:new).and_return(@channels)
      @channels.stub!(:save)
    end

    def do_create
      post :create, user_id: 1, channel: { name: 'Foo name', url: "http://www.foo.com" }
    end

    context "with valid info" do
      it "builds a new channel instance" do
        controller.should_receive(:current_user).and_return(@user)
        @user.should_receive(:channels).and_return(@channels)
        @channels.should_receive(:new).with({"name"=>"Foo name", "url"=>"http://www.foo.com"}).and_return(@channels)
        do_create
      end

      it "assigns the new instance channel to @channel" do
        do_create
        assigns(:channel).should == @channels
      end

      it "does create a new channel" do
        @channels.should_receive(:save).and_return(true)
        do_create
      end

      it "renders the index template" do
        @channels.should_receive(:save).and_return(true)
        do_create
        response.should be_redirect
        flash[:notice].should eql("Channel was successfully created.")
      end
    end

    context "without valid info" do
      it "does not save the channel" do
        @channels.should_receive(:save).and_return(false)
        post :create, user_id: 1, channel: {}
      end

      it "renders the new template" do
        post :create, user_id: 1, channel: {}
        response.should render_template :new
        flash[:alert].should eql("There were some errors")
      end
    end
  end

  describe "#edit" do
    before do
      @channels.stub!(:where).and_return(@channels)
      @channels.stub!(:first).and_return(@channels)
    end

    it "finds a request channel" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:channels).and_return(@channels)
      @channels.should_receive(:where).with({id: "1"}).and_return(@channels)
      @channels.should_receive(:first).and_return(@channels)
      get :edit, user_id: 1, id: 1
    end

    it "assigns the request channel to @channel" do
      get :edit, user_id: 1, id: 1
      assigns(:channel).should == @channels
    end

    it "renders the edit template" do
      get :edit, user_id: 1, id: 1
      response.should render_template :edit
    end
  end

  describe "#update" do
    before do
      @channels.stub!(:where).and_return(@channels)
      @channels.stub!(:first).and_return(@channels)
      @channels.stub!(:update_attributes)
    end

    def do_update
      put :update, user_id: 1, id: 1, channel: { name: 'Foo name 2' }
    end

    it "finds a request channel" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:channels).and_return(@channels)
      @channels.should_receive(:where).with({id: "1"}).and_return(@channels)
      @channels.should_receive(:first).and_return(@channels)
      do_update
    end

    it "assigns the request channel to @channel" do
      do_update
      assigns(:channel).should == @channels
    end

    context "with valid info" do
      it "does update the request channel" do
        @channels.should_receive(:update_attributes).and_return(true)
        do_update
      end

      it "does respond the index template" do
        @channels.should_receive(:update_attributes).and_return(true)
        do_update
        response.should be_redirect
        flash[:notice].should eql("Channel was successfully updated.")
      end
    end

    context "without valid info" do
      it "does not update the request channel" do
        @channels.should_receive(:update_attributes).and_return(false)
        put :update, user_id: 1, id: 1, channel: {}
      end

      it "renders the edit template" do
        put :update, user_id: 1, id: 1, channel: {}
        response.should render_template :edit
        flash[:alert].should eql("There were some errors")
      end
    end
  end

  describe "#destroy" do
    before do
      @channels.stub!(:where).and_return(@channels)
      @channels.stub!(:first).and_return(@channels)
      @channels.stub!(:destroy)
    end

    it "finds a request channel" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:channels).and_return(@channels)
      @channels.should_receive(:where).with({id: "1"}).and_return(@channels)
      @channels.should_receive(:first).and_return(@channels)
      delete :destroy, user_id: 1, id: 1
    end

    it "assigns the request channel to @channel" do
      delete :destroy, user_id: 1, id: 1
      assigns(:channel).should == @channels
    end

    it "does detroy the request channel" do
      @channels.should_receive(:destroy).and_return(true)
      delete :destroy, user_id: 1, id: 1
    end

    it "does respond with redirect" do
      delete :destroy, user_id: 1, id: 1
      response.should be_redirect
      flash[:notice].should eql("Channel was successfully deleted.")
    end
  end
end
