require "spec_helper"

describe "Viewing a individual project" do
  it "shows a project's details" do
    project = Project.create(project_attributes(target_pledge_amount: 100))

    visit project_path(project)

    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$100")
    expect(page).to have_text("1 day remaining")
    expect(page).to have_text(project.website)
    expect(page).to have_text(project.team_members)
    expect(page).to have_selector("img[src$='#{project.image_file_name}']")
  end

  it "shows the number of days remaining if the pledging end date is in the future" do
    project = Project.create(project_attributes(pledging_ends_on: 1.day.from_now))

    visit project_path(project)

    expect(page).to have_text("1 day remaining")
  end

  it "shows 'All Done!', if the pledging end date is in the past" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.ago))

    visit project_path(project)

    expect(page).to have_text("All Done!")
    expect(page).to have_text("Edit")
  end
end
