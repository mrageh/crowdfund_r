require "spec_helper"

describe "Viewing a individual project" do
  it "shows a project's details" do
    project = Project.create(name: "Start-Up Project",
                              description: "A description of a start-up project",
                              target_pledge_amount: 100.00,
                              pledging_ends_on: 1.day.from_now,
                              website: "http://project-a.com")

    visit project_path(project)

    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$100")
    expect(page).to have_text(project.website)
  end
end
