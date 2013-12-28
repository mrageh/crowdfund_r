require "spec_helper"

describe "Deleting a project" do
  it "removes it from the project listing page and the whole website" do
  project = Project.create(project_attributes(pledging_ends_on: 1.day.from_now))

  visit project_path(project)

  expect(Project.count).to eq(1)

  click_on "Delete"

  expect(current_path).to eq(projects_path)
  expect(page).to have_text("Project successfully deleted!")
  expect(Project.count).to eq(0)
  end
end
