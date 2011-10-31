require 'spec_helper'

describe NothingHelper do
  describe "placeholder html helper" do
    it "takes a width and height and makes an image tag" do
      helper.placeholder(200,100).should == 
        '<img alt="placeholder" src="http://placekitten.com/g/200/100" />'
    end
  end
end
