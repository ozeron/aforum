class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :discussions, inverse_of: :user, dependent: :destroy
  has_many :comments, inverse_of: :user, dependent: :destroy

  validates :nickname,
            format: { with: /\A[A-Za-z0-9_.]+\z/ },
            length: { maximum: 255 },
            presence: true
  validates :email,
            format: { with: /\A[A-Za-z0-9_.]+@[A-Za-z0-9_.]+\z/},
            presence: true
  validates :password,
            length: {minimum: 8},
            presence: true
end
