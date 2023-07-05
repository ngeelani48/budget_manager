class Group < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :transactions
  validates :name, presence: true, length: { maximum: 255 }
  has_one_attached :image

  def total_amount
    transactions.sum(:amount)
  end
end
