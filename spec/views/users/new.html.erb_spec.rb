require 'spec_helper'

describe "users/new.html.erb" do
  it "renders without failure" do
    assign :user, stub_model(User)
    render
  end
end
