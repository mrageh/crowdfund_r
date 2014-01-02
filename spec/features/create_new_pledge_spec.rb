require 'spec_helper'

describe "Creating a Pledge" do
  it "saves a valid pledge to its associated project" do
    project = Project.create(project_attributes)

    visit project_path(project)
    click_on "Pledge!"

    expect(current_path).to eq(new_project_pledge_path(project))
    expect(page).to have_text("New Pledge for #{project.name}")

    fill_in "Name", with: "MrGenerous"
    fill_in "Email", with: "generous@gmail.com"
    select 500, from: "Amount"
    fill_in "Comment", with: "Am so rich and generous I give money away"
    click_on "Create Pledge"

    expect(current_path).to eq(project_pledges_path(project))
    expect(page).to have_text("MrGenerous")
    expect(page).to have_text("$500")
    expect(page).to have_text("Thanks for pledging!")
  end

  it "does not save a invalid pledge" do
    project = Project.create(project_attributes)

    visit project_path(project)
    click_on "Pledge!"

    expect(current_path).to eq(new_project_pledge_path(project))
    expect(page).to have_text("New Pledge for #{project.name}")

    click_on "Create Pledge"

    expect(page).to have_text("3 errors")
  end
end
