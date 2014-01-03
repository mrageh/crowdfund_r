class Project < ActiveRecord::Base

  validates :name, presence: true

  validates :description, length: { minimum: 25, maximum: 500 }

  validates :target_pledge_amount, numericality: {greater_than: 0}

  validates :website, format: {
    with: /https?:\/\/[\S]+\b/i,
    message: "must reference a valid URL"
  }

  validates :image_file_name, allow_blank: true,  format: {
    with: /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }

  has_many :pledges, dependent: :destroy

  def pledging_expired?
    pledging_ends_on < Date.today
  end

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on")
  end

  def image_blank?
    image_file_name.blank?
  end

  def total_amount
    pledges.sum(:amount)
  end

  def outstanding_amount
    target_pledge_amount - total_amount
  end

  def fully_funded?
    target_pledge_amount <= total_amount
  end
end
