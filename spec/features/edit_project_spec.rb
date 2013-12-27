require "spec_helper"

describe "Editing individual movies" do
  it "show's a form to update movie attributes" do
    project = Project.create(project_attributes())

    visit edit_project_path(project)

    expect(page).to have_text("Editing #{project.name}")

    fill_in "Name", with: "Adeer"
    fill_in "Description", with: "Well I cannot build it because I dont have any time"
    fill_in "Target pledge amount", with: 100
    select "2013", from: "project[pledging_ends_on(1i)]"
    select "October", from: "project[pledging_ends_on(2i)]"
    select "26", from: "project[pledging_ends_on(3i)]"
    fill_in "Website", with: "http://ikky.com"

    click_button "Update Project"

    expect(page).to have_text("Adeer")
  end
end
