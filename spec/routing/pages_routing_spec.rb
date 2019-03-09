require "rails_helper"

RSpec.describe "routes for Pages", :type => :routing do

  context "routes to the pages controller" do
    it "routes /order_dvd to the pages controller" do
      expect(get("/order_dvd")).to route_to("controller"=>"pages", "action"=>"show", "path"=>"order_dvd")
    end

    it "routes /order_dvd_2018 to the pages controller" do
      expect(get("/order_dvd_2018")).to route_to("controller"=>"pages", "action"=>"show", "path"=>"order_dvd_2018")
    end
  end

end
