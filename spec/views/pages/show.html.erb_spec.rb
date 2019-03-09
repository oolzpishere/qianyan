require "rails_helper"

RSpec.describe "pages show" do
  it "order_dvd link to right template" do
    render :template => "pages/order_dvd.html.erb"
    expect(rendered).to match /2019年春全国初中数学前沿课堂观摩研讨会/
  end

  it "order_dvd_2018 link to right template" do
    render :template => "pages/order_dvd_2018.html.erb"
    expect(rendered).to match /2018年秋全国小学数学前沿课堂观摩研训会/
  end
end
