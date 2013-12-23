class Project < ActiveRecord::Base
  def pledging_expired?
    pledging_ends_on < Date.today
  end

  def self.ongoing
    where("pledging_ends_on >= ?", Time.now).order("pledging_ends_on")
  end
end
