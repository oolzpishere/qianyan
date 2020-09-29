require "rails_helper"

RSpec.describe StreamsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/streams").to route_to("streams#index")
    end

    it "routes to #new" do
      expect(:get => "/streams/new").to route_to("streams#new")
    end

    it "routes to #show" do
      expect(:get => "/streams/1").to route_to("streams#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/streams/1/edit").to route_to("streams#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/streams").to route_to("streams#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/streams/1").to route_to("streams#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/streams/1").to route_to("streams#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/streams/1").to route_to("streams#destroy", :id => "1")
    end
  end
end
