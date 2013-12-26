require "spec_helper"

describe "A project" do
  it "has expired if the pledging ends on date is in the past" do
    project = Project.new(pledging_ends_on: 2.days.ago)

    expect(project.pledging_expired?).to eq(true)
  end

  it "has not expired if the pledging ends on date is in the future" do
    project = Project.new(pledging_ends_on: 2.days.from_now)

    expect(project.pledging_expired?).to eq(false)
  end

  it "is only listed if it is accepting pledges" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.from_now))

    expect(Project.accepting_pledges).to include(project)
  end

  it "is not listed if is not accepting pledges" do
    project = Project.create(project_attributes(pledging_ends_on: 3.days.ago))

    expect(Project.accepting_pledges).not_to include(project)
  end

  it "is ordered by which one has the nearest ending date for pledges" do
    project1 = Project.create(project_attributes(pledging_ends_on: 3.days.from_now))
    project2 = Project.create(project_attributes(pledging_ends_on: 2.days.from_now))
    project3 = Project.create(project_attributes(pledging_ends_on: 1.days.from_now))

    expect(Project.accepting_pledges).to eq([project3, project2, project1])
  end

  it "can have a image" do
    project = Project.create(project_attributes(image_file_name: nil))

    expect(Project.last.image_blank?).to eq(true)
  end

  it "requires a name"

  it "requires a description"

  it "accepts a description up to 500 characters"

  it "accepts a positive target pledge amount"

  it "rejects a $0 target pledge amount"

  it "rejects a negative target pledge amount"

  it "accepts properly formatted website URLs"

  it "rejects improperly formatted website URLs"

  it "accepts properly formatted image file names"

  it "rejects improperly formatted image file names"
end
