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

    expect(project.image_blank?).to eq(true)
  end

  it "requires a name" do
    project = Project.create(project_attributes(name: nil))

    expect(project.valid?).to be_false
    expect(project.errors[:name].any?).to be_true
  end

  it "requires a description" do
    project = Project.create(project_attributes(description: nil))

    expect(project.valid?).to be_false
    expect(project.errors[:description].any?).to be_true
  end

  it "accepts a description up to 500 characters" do
    project = Project.create(project_attributes(description: "D" * 500))

    expect(project.valid?).to be_true
    expect(project.errors[:description].any?).to be_false
  end

  it "accepts a positive target pledge amount" do
    project = Project.create(project_attributes(target_pledge_amount: 100))

    expect(project.valid?).to be_true
    expect(project.errors[:target_pledge_amount].any?).to be_false
  end

  it "rejects a $0 target pledge amount" do
    project = Project.create(project_attributes(target_pledge_amount: 0))

    expect(project.valid?).to be_false
    expect(project.errors[:target_pledge_amount].any?).to be_true
  end

  it "rejects a negative target pledge amount" do
    project = Project.create(project_attributes(target_pledge_amount: -10))

    expect(project.valid?).to be_false
    expect(project.errors[:target_pledge_amount].any?).to be_true
  end

  it "accepts properly formatted website URLs" do
    sites = %w[http://example.com https://example]
    sites.each do |site|
      project = Project.create(project_attributes(website: site))

      expect(project.valid?).to be_true
      expect(project.errors[:website].any?).to be_false
    end
  end

  it "rejects improperly formatted website URLs" do
    sites = %w[example.com http examplehttp]
    sites.each do |site|
      project = Project.new(website: site)

      expect(project.valid?).to be_false
      expect(project.errors[:website].any?).to be_true
    end
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png event.png event.jpg event.gif EVENT.GIF]
    file_names.each do |file_name|
      project = Project.new(image_file_name: file_name)

      expect(project.valid?).to be_false
      expect(project.errors[:image_file_name].any?).to be_false
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[event .jpg .png .gif event.pdf event.doc]
    file_names.each do |file_name|
      project = Project.new(image_file_name: file_name)

      expect(project.valid?).to be_false
      expect(project.errors[:image_file_name].any?).to be_true
    end
  end

end
