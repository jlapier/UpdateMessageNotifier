require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      response.should render_template('new')
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        @mock_user = mock_model(User, :save => true)
        User.stub(:new).and_return(@mock_user)
      end
        
      it "makes new user" do
        post :create, :stuff => 'whatever'
        assigns(:user).should eq(@mock_user)
      end

      it "redirects to root url" do
        post :create, :stuff => 'whatever'
        response.should redirect_to(root_url)
      end

      it "logs new user in via session" do
        post :create, :stuff => 'whatever'
        session[:user_id].should eq(@mock_user.id)
      end
    end

    describe "with invalid params" do
      it "should re-render the new template" do
        mock_user = mock_model(User, :save => false)
        User.stub(:new).and_return(mock_user)
        post :create, :stuff => 'whatever'
        response.should render_template('new') 
      end

    end
  end
end
