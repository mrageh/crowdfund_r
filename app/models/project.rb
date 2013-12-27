class Project < ActiveRecord::Base
  validates :name, presence: true

  validates :description, length: { minimum: 25, maximum: 500 }

  validates :target_pledge_amount, numericality: {greater_than: 0}

  validates :website, format: {
    with: /https?:\/\/[\S]+\b/i,
    message: "must reference a valid URL"
  }

  validates :image_file_name, format: {
    with: /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }

  def pledging_expired?
    pledging_ends_on < Date.today
  end

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on")
  end

  def image_blank?
    image_file_name.blank?
  end
end
