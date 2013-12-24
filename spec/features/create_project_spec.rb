require "spec_helper"

describe "Creating a new project" do
  it "saves the project and shows the new project's details" do
    visit root_path
    click_on "Add New Project"

    expect(current_path).to eq(new_project_path)
    expect(page).to have_text("Add New Project")

    fill_in "Name", with: "Kids"
    fill_in "Description", with: "A fund raising events for the orphaned kids"
    fill_in "Target pledge amount", with: 100000
    fill_in "Website", with: "www.poorkids.com"
    fill_in "Team members", with: "gSchool"
    fill_in "Image file name", with: "placeholder.png"
    select "2014", from: "project[pledging_ends_on(1i)]"
    select "October", from: "project[pledging_ends_on(2i)]"
    select "30", from: "project[pledging_ends_on(3i)]"
    click_on "Create Project"

    expect(current_path).to eq(project_path(Project.last))
    expect(page).to have_text("Kids")
  end
end
