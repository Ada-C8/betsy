require "test_helper"

describe MainController do

  describe "#index" do
    it "should respond with success" do
      get root_path
      must_respond_with :success
    end
  end
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end
