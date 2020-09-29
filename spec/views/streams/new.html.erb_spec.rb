require 'rails_helper'

RSpec.describe "streams/new", type: :view do
  before(:each) do
    assign(:stream, Stream.new())
  end

  it "renders new stream form" do
    render

    assert_select "form[action=?][method=?]", streams_path, "post" do
    end
  end
end
