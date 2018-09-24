require 'test_helper'

class DvdRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dvd_request = dvd_requests(:one)
  end

  test "should get index" do
    get dvd_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_dvd_request_url
    assert_response :success
  end

  test "should create dvd_request" do
    assert_difference('DvdRequest.count') do
      post dvd_requests_url, params: { dvd_request: {  } }
    end

    assert_redirected_to dvd_request_url(DvdRequest.last)
  end

  test "should show dvd_request" do
    get dvd_request_url(@dvd_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_dvd_request_url(@dvd_request)
    assert_response :success
  end

  test "should update dvd_request" do
    patch dvd_request_url(@dvd_request), params: { dvd_request: {  } }
    assert_redirected_to dvd_request_url(@dvd_request)
  end

  test "should destroy dvd_request" do
    assert_difference('DvdRequest.count', -1) do
      delete dvd_request_url(@dvd_request)
    end

    assert_redirected_to dvd_requests_url
  end
end
