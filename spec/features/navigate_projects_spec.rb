require "spec_helper"
describe "Navigate projects" do
  it "allows navigation from the detail's page to the listing page" do
    project = Project.create(project_attributes)

    visit project_path(project)

    click_link "All Projects"

    expect(current_path).to eq(projects_path)
  end

  it "allows navigation from the listing page to the detail's page" do
    project = Project.create(project_attributes)

    visit projects_path

    click_link project.name

    expect(current_path).to eq(project_path(project))
  end
end
