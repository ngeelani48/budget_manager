class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups, dependent: :destroy

  has_many :transactions, dependent: :destroy

  validates :fullname, :email, presence: true, length: { maximum: 255 }

  validates :email, uniqueness: true
end
