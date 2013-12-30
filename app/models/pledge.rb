class Pledge < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true

  validates :email, format: { with: /(\S+)@(\S+)/ }

  AMOUNT_LEVELS = [25, 50 ,100, 200, 500]

  validates :amount, inclusion: { in: AMOUNT_LEVELS }
end
