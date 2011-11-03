require 'spec_helper'

describe "update_messages/edit.html.erb" do
  it "renders without failure" do
    assign :update_message, stub_model(UpdateMessage)
    render
  end
end
