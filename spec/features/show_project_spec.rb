require "spec_helper"

describe "Viewing a individual project" do
  xit "shows a project's details" do
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

  xit "shows the number of days remaining if the pledging end date is in the future" do
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

  it "shows the amount outstanding with a pledge link if the project is not fully funded" do
    project = Project.create(project_attributes)

    visit project_path(project)

    expect(page).to have_text("Outstanding Amount")
    expect(page).to have_text("$100")
    expect(page).to have_text("Pledge!")
  end

  it "shows 'Funded' without a pledge link if the project is funded" do
    project = Project.create(project_attributes)
    10.times {project.pledges.create(pledge_attributes)}

    visit project_path(project)

    expect(page).to have_text("Fully Funded")
    expect(page).to_not have_text("Pledge!")
  end
end
