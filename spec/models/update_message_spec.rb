require 'spec_helper'

describe UpdateMessage do
  before(:each) do
    @mock_user = mock_model(User)
  end

  it "creates a new message" do
    UpdateMessage.create! :subject => "New Subject", :body => "Blah blah blah.",
      :user => @mock_user
  end

  it "has a scope for finding published messages" do
    um_a = UpdateMessage.create! :subject => "Published A", :body => "Blah blah.",
      :user => @mock_user, :published_on => 2.days.ago
    um_b = UpdateMessage.create! :subject => "Unpublished B", :body => "Blah blah.",
      :user => @mock_user
    um_c = UpdateMessage.create! :subject => "Future Publish C", :body => "Blah.",
      :user => @mock_user, :published_on => 2.days.from_now
    UpdateMessage.published.should eq([um_a])

    um_b.update_attributes :published_on => 1.day.ago, :subject => "Published B"
    UpdateMessage.published.should eq([um_b, um_a])
  end
end
