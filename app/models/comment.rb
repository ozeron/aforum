class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments, dependent: :destroy
  belongs_to :discussion, inverse_of: :comments, dependent: :destroy
end