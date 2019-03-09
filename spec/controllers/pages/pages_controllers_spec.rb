require 'rails_helper'

RSpec.describe PagesController do
  describe "GET show" do
    it "order_dvd render right template" do
      get :show, :params => { path: 'order_dvd'}
      expect(response).to render_template("order_dvd")
    end

    it "order_dvd_2018 render right template" do
      get :show, :params => { path: 'order_dvd_2018'}
      expect(response).to render_template("order_dvd_2018")
    end
  end
end
