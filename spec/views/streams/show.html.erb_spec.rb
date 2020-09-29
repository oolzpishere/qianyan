require 'rails_helper'

RSpec.describe "streams/show", type: :view do
  before(:each) do
    @stream = assign(:stream, Stream.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
