require 'test_helper'

class DvdResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dvd_result = dvd_results(:one)
  end

  test "should get index" do
    get dvd_results_url
    assert_response :success
  end

  test "should get new" do
    get new_dvd_result_url
    assert_response :success
  end

  test "should create dvd_result" do
    assert_difference('DvdResult.count') do
      post dvd_results_url, params: { dvd_result: {  } }
    end

    assert_redirected_to dvd_result_url(DvdResult.last)
  end

  test "should show dvd_result" do
    get dvd_result_url(@dvd_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_dvd_result_url(@dvd_result)
    assert_response :success
  end

  test "should update dvd_result" do
    patch dvd_result_url(@dvd_result), params: { dvd_result: {  } }
    assert_redirected_to dvd_result_url(@dvd_result)
  end

  test "should destroy dvd_result" do
    assert_difference('DvdResult.count', -1) do
      delete dvd_result_url(@dvd_result)
    end

    assert_redirected_to dvd_results_url
  end
end
