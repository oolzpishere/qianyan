require "application_system_test_case"

class DvdResultsTest < ApplicationSystemTestCase
  setup do
    @dvd_result = dvd_results(:one)
  end

  test "visiting the index" do
    visit dvd_results_url
    assert_selector "h1", text: "Dvd Results"
  end

  test "creating a Dvd result" do
    visit dvd_results_url
    click_on "New Dvd Result"

    click_on "Create Dvd result"

    assert_text "Dvd result was successfully created"
    click_on "Back"
  end

  test "updating a Dvd result" do
    visit dvd_results_url
    click_on "Edit", match: :first

    click_on "Update Dvd result"

    assert_text "Dvd result was successfully updated"
    click_on "Back"
  end

  test "destroying a Dvd result" do
    visit dvd_results_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dvd result was successfully destroyed"
  end
end
