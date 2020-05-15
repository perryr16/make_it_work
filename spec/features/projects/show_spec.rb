require 'rails_helper'

RSpec.describe "the Projects show page" do

  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
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

  it "returns count of contestants per project" do
    visit "/projects/#{@news_chic.id}"

    within("#projects-#{@news_chic.id}")do
      expect(page).to have_content("Project Name: #{@news_chic.name}")
      expect(page).to have_content("Material: #{@news_chic.material}")
      expect(page).to have_content("Challenge Theme: #{@news_chic.challenge.theme}")
      expect(page).to have_content("Number of Contestants: #{@news_chic.contestant_count}")
    end

    visit "/projects/#{@boardfit.id}"
    within("#projects-#{@boardfit.id}")do
    expect(page).to have_content("Project Name: #{@boardfit.name}")
    expect(page).to have_content("Material: #{@boardfit.material}")
    expect(page).to have_content("Challenge Theme: #{@boardfit.challenge.theme}")
    expect(page).to have_content("Number of Contestants: #{@boardfit.contestant_count}")
    end

    visit "/projects/#{@upholstery_tux.id}"
    within("#projects-#{@upholstery_tux.id}")do
    expect(page).to have_content("Project Name: #{@upholstery_tux.name}")
    expect(page).to have_content("Material: #{@upholstery_tux.material}")
    expect(page).to have_content("Challenge Theme: #{@upholstery_tux.challenge.theme}")
    expect(page).to have_content("Number of Contestants: #{@upholstery_tux.contestant_count}")
    end
    visit "/projects/#{@lit_fit.id}"
    within("#projects-#{@lit_fit.id}")do
    expect(page).to have_content("Project Name: Litfit")
    expect(page).to have_content("Material: Lamp")
    expect(page).to have_content("Challenge Theme: Apartment Furnishings")
    expect(page).to have_content("Number of Contestants: 0")
    end


  end
end

# User Story 3 of 3
# As a visitor,
# When I visit a project's show page
# I see a count of the number of contestants on this project
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings
#   Number of Contestants: 3 )
