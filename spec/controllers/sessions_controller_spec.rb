require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      response.should render_template('new')
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        @mock_user = mock_model(User, :authenticate => true)
        User.stub(:find_by_email).and_return(@mock_user)
      end

      it "redirects to root url" do
        post :create, :stuff => 'whatever'
        response.should redirect_to(root_url)
      end

      it "logs new user in via session" do
        post :create, :stuff => 'whatever'
        session[:user_id].should eq(@mock_user.id)
      end

      it "makes current_user set to the logged in user" do
        post :create, :stuff => 'whatever'
        User.stub(:find).with(@mock_user.id).and_return(@mock_user)
        controller.current_user.should eq(@mock_user)
      end

      it "provides is_admin? helper as true for admin user" do
        @mock_user.stub(:is_admin?).and_return(true)
        post :create, :stuff => 'whatever'
        User.stub(:find).with(@mock_user.id).and_return(@mock_user)
        controller.is_admin?.should be_true
      end

      it "provides is_admin? helper as false for regular user" do
        @mock_user.stub(:is_admin?).and_return(false)
        post :create, :stuff => 'whatever'
        User.stub(:find).with(@mock_user.id).and_return(@mock_user)
        controller.is_admin?.should be_false
      end
    end

    describe "with invalid params" do
      it "should re-render the new login template" do
        @mock_user = mock_model(User, :authenticate => false)
        User.stub(:find_by_email).and_return(@mock_user)
        post :create, :stuff => 'whatever'
        response.should render_template('new') 
      end
    end
  end

  describe "DELETE destroy" do
    it "should log the user out" do
      delete :destroy
      session[:user_id].should be_nil
    end

    it "redirects to root url" do
      delete :destroy
      response.should redirect_to(root_url)
    end
  end
end
