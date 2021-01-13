require "test_helper"

class BatchuploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get batchuploads_input_url
    assert_response :success
  end

  test "should get output" do
    get batchuploads_output_url
    assert_response :success
  end
end
