require "application_system_test_case"

class DvdRequestsTest < ApplicationSystemTestCase
  setup do
    @dvd_request = dvd_requests(:one)
  end

  test "visiting the index" do
    visit dvd_requests_url
    assert_selector "h1", text: "Dvd Requests"
  end

  test "creating a Dvd request" do
    visit dvd_requests_url
    click_on "New Dvd Request"

    click_on "Create Dvd request"

    assert_text "Dvd request was successfully created"
    click_on "Back"
  end

  test "updating a Dvd request" do
    visit dvd_requests_url
    click_on "Edit", match: :first

    click_on "Update Dvd request"

    assert_text "Dvd request was successfully updated"
    click_on "Back"
  end

  test "destroying a Dvd request" do
    visit dvd_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dvd request was successfully destroyed"
  end
end
