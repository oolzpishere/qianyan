require 'rails_helper'

RSpec.describe "streams/index", type: :view do
  before(:each) do
    assign(:streams, [
      Stream.create!(),
      Stream.create!()
    ])
  end

  it "renders a list of streams" do
    render
  end
end
