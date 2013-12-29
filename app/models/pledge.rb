class Pledge < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true

  validates :email, format: { with: /(\S+)@(\S+)/ }
end
