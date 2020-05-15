require 'rails_helper'

RSpec.describe "the Projects show page" do

  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
  end

  it "lists the project name, material and challenge it belongs to" do
    visit "/projects/#{@news_chic.id}"

    within("#projects-#{@news_chic.id}")do
      expect(page).to have_content("Project Name: News Chic")
      expect(page).to have_content("Material: Newspaper")
      expect(page).to have_content("Challenge Theme: Recycled Material")
    end

    visit "/projects/#{@lit_fit.id}"

    within("#projects-#{@lit_fit.id}")do
      expect(page).to have_content("Project Name: Litfit")
      expect(page).to have_content("Material: Lamp")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")
    end



  end
end
