class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :discussion, inverse_of: :comments
  def self.initialize_with content, opt
    comment = Comment.new content
    comment.user = opt[:user]
    comment.discussion = opt[:discussion]
    comment
  end
end