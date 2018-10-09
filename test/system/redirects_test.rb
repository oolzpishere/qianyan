require "application_system_test_case"

class RedirectsTest < ApplicationSystemTestCase
  setup do
    @redirect = redirects(:one)
  end

  test "visiting the index" do
    visit redirects_url
    assert_selector "h1", text: "Redirects"
  end

  test "creating a Redirect" do
    visit redirects_url
    click_on "New Redirect"

    click_on "Create Redirect"

    assert_text "Redirect was successfully created"
    click_on "Back"
  end

  test "updating a Redirect" do
    visit redirects_url
    click_on "Edit", match: :first

    click_on "Update Redirect"

    assert_text "Redirect was successfully updated"
    click_on "Back"
  end

  test "destroying a Redirect" do
    visit redirects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Redirect was successfully destroyed"
  end
end
