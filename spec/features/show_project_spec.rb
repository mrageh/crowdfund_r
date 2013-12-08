require "spec_helper"

describe "Viewing a individual project" do
  it "shows a project's details" do
    project = Project.create(project_attributes(target_pledge_amount: 100))

    visit project_path(project)

    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$100")
    expect(page).to have_text(project.website)
  end
end
