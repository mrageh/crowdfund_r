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

  it "accepts valid amounts" do
    amounts = Pledge::AMOUNT_LEVELS
    amounts.each do |amount|
      pledge = Pledge.create(pledge_attributes(amount: amount))

      expect(pledge.valid?).to be_true
      expect(pledge.errors[:amount].any?).to be_false
    end
  end

  it "rejects invalid amounts" do
    amounts = [-10.00, 0.00, 13.00]
    amounts.each do |amount|
      pledge = Pledge.new(amount: amount)

      expect(pledge.valid?).to be_false
      expect(pledge.errors[:amount].any?).to be_true
    end
  end
end
