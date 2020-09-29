require 'rails_helper'

RSpec.describe "streams/edit", type: :view do
  before(:each) do
    @stream = assign(:stream, Stream.create!())
  end

  it "renders the edit stream form" do
    render

    assert_select "form[action=?][method=?]", stream_path(@stream), "post" do
    end
  end
end
