require "test_helper"

describe StaticPagesController do

  it "should get home page" do
    get root_path
    must_respond_with :success
  end

end
