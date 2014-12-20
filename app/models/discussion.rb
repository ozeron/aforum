class Discussion < ActiveRecord::Base
  belongs_to :user, inverse_of: :discussions
  has_many :comments, inverse_of: :discussion
  validates :title,
            length: { minimum: 3},
            presence: true
  validates :description,
            length: { minimum: 3},
            presence: true
end