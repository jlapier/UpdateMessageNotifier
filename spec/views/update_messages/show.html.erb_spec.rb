require 'spec_helper'

describe "update_messages/show.html.erb" do
  it "renders without failure" do
    view.stub(:user_is_admin?).and_return(false)
    assign :update_message, stub_model(UpdateMessage)
    render
  end
end
