require 'spec_helper'

describe NothingController do
  describe "GET index" do
    it "does not really do anything except render index template" do
      get :index
      response.should render_template('index')
    end
  end
end
