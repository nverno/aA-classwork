# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author,
             foreign_key: :author_id,
             class_name: 'User'

  belongs_to :parent_comment,
             foreign_key: :parent_comment_id,
             class_name: 'Comment',
             optional: true

  has_many :child_comments,
           foreign_key: :parent_comment_id,
           class_name: 'Comment'

  has_many :votes, as: :votable

  def vote_count
    votes.sum(:value)
  end

  def upvoted_by?(user)
    Vote.exists?(user_id: user.id, votable_id: id, votable_type: 'Comment', value: 1)
  end

  def downvoted_by?(user)
    Vote.exists?(user_id: user.id, votable_id: id, votable_type: 'Comment', value: -1)
  end
end
