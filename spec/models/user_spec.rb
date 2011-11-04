require 'spec_helper'

describe User do
  describe "when creating new users" do
    it "should create with proper attribs" do
      User.create! :email => "someone@example.com", :password => "testtest", :password_confirmation => "testtest"
    end

    it "should not create if password is not confirmed" do
      u = User.new :email => "someone@example.com", :password => "testtest", :password_confirmation => "testwrong"
      u.should_not be_valid
    end

    it "should not create without attrs" do
      u = User.new
      u.should_not be_valid
    end
  end

  describe "when reading messages" do
    it "should update last read message" do
      user = User.create! :email => "someone@example.com", :password => "testtest", 
        :password_confirmation => "testtest"
      mess = mock_model(UpdateMessage, :published_on => true)
      assert user.update_last_read_message(mess)
      user.last_read_message.should eq(mess)
    end
    it "should not update last read message if unpublished" do
      user = User.create! :email => "someone@example.com", :password => "testtest", 
        :password_confirmation => "testtest"
      mess = mock_model(UpdateMessage, :published_on => false)
      user.update_last_read_message(mess)
      user.last_read_message.should be_nil
    end
  end
end
