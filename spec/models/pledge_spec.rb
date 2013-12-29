require 'spec_helper'

describe Pledge do

  it "belongs to a project" do
    project = Project.create(project_attributes())
    pledge = Pledge.create(pledge_attributes())

    expect(pledge.project).to eq(project)
  end

  it "requires a name" do
    pledge = Pledge.create(pledge_attributes(name: nil))

    expect(pledge.valid?).to be_false
    expect(pledge.errors[:name].any?).to be_true
  end

  it "accepts properly formatted emails" do
    pledge = Pledge.create(pledge_attributes())

    expect(pledge.valid?).to be_true
    expect(pledge.errors[:email].any?).to be_false
  end

  it "rejects improperly formatted emails" do
    pledge = Pledge.create(pledge_attributes(email: "pledgehotmail.com"))

    expect(pledge.valid?).to be_false
    expect(pledge.errors[:email].any?).to be_true
  end

  it "accepts valid amounts"

  it "rejects invalid amounts"
end
