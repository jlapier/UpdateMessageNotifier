require 'spec_helper'

describe UpdateMessagesController do
  describe "when not logged in or logged in as regular user" do
    describe "GET index" do
      before(:each) do
        @mock_um = mock_model(UpdateMessage)
        UpdateMessage.stub_chain(:published, :limit) { [@mock_um] }
      end
      it "gets a list of update messages" do
        get :index
        assigns(:update_messages).should eq([@mock_um])
      end
      it "renders the index template" do
        get :index
        response.should render_template('index')
      end
    end

    describe "GET show" do
      describe "when published message" do
        before(:each) do
          @mock_um = mock_model(UpdateMessage, :published_on => 3.days.ago)
          UpdateMessage.stub(:find).and_return(@mock_um)
        end
        it "gets the message" do
          get :show, :id => 1
          assigns(:update_message).should eq(@mock_um)
        end
        it "renders the show template" do
          get :show, :id => 1
          response.should render_template('show')
        end
      end    
      describe "when unpublished message" do
        before(:each) do
          @mock_um = mock_model(UpdateMessage, :published_on => nil)
          UpdateMessage.stub(:find).and_return(@mock_um)
        end
        it "redirects to index" do
          get :show, :id => 1
          response.should redirect_to(update_messages_url)
        end
      end    
    end

    describe "GET edit" do
      it "redirects non-admin user to root" do
        get :edit, :id => 1
        response.should redirect_to(root_url)
      end
    end
    describe "POST create" do
      it "redirects non-admin user to root" do
        post :create, :update_message => { }
        response.should redirect_to(root_url)
      end
    end
    describe "PUT update" do
      it "redirects non-admin user to root" do
        put :update, :id => 1, :update_message => { }
        response.should redirect_to(root_url)
      end
    end
    describe "DELETE destroy" do
      it "redirects non-admin user to root" do
        delete :destroy, :id => 1
        response.should redirect_to(root_url)
      end
    end
  end


  #### ADMIN ACCESS
  describe "when logged in as admin user" do
    before(:each) do
      @admin = mock_model(User, :is_admin? => true)
      controller.stub(:current_user).and_return(@admin)
    end
    describe "GET show" do
      describe "when unpublished message" do
        before(:each) do
          @mock_um = mock_model(UpdateMessage, :published_on => nil)
          @admin.stub(:update_last_read_message).and_return(true)
          UpdateMessage.stub(:find).and_return(@mock_um)
        end
        it "gets the message" do
          get :show, :id => 1
          assigns(:update_message).should eq(@mock_um)
        end
        it "renders the show template" do
          get :show, :id => 1
          response.should render_template('show')
        end
      end    
    end
    describe "GET new" do
      it "renders the new template" do
        get :new
        assigns(:update_message).should_not be_nil
        response.should render_template('new')
      end
    end
    describe "GET edit" do
      before(:each) do
        @mock_um = mock_model(UpdateMessage)
        UpdateMessage.stub(:find).and_return(@mock_um)
      end
      it "gets the message" do
        get :edit, :id => 1
        assigns(:update_message).should eq(@mock_um)
      end
      it "renders the edit template" do
        get :edit, :id => 1
        response.should render_template('edit')
      end
    end
    describe "POST create" do
      it "redirects to show" do
        @mock_um = mock_model(UpdateMessage, :user= => nil, :save => true)
        UpdateMessage.stub(:new).and_return(@mock_um)
        post :create, :update_message => { }
        response.should redirect_to(@mock_um)
      end
    end
    describe "PUT update" do
      before(:each) do
        @mock_um = mock_model(UpdateMessage, :update_attributes => true)
        UpdateMessage.stub(:find).and_return(@mock_um)
      end
      it "gets the message" do
        put :update, :id => 1, :update_message => { }
        assigns(:update_message).should eq(@mock_um)
      end
      it "redirects to show" do
        put :update, :id => 1, :update_message => { }
        response.should redirect_to(@mock_um)
      end
    end
    describe "DELETE destroy" do
      it "redirects to index" do
        UpdateMessage.should_receive(:destroy).with("1")
        delete :destroy, :id => 1
        response.should redirect_to(update_messages_url)
      end
    end
  end
end
