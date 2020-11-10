# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :string           default("")
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Sub < ApplicationRecord
  belongs_to :moderator,
             foreign_key: :moderator_id,
             class_name: :User

  has_many :post_subs

  has_many :posts,
           through: :post_subs,
           source: :post

  has_many :votes, as: :votable

  def vote_count
    votes.sum(:value)
  end

  def upvoted_by?(user)
    Vote.exists?(user_id: user.id, votable_id: id, votable_type: 'Sub', value: 1)
  end

  def downvoted_by?(user)
    Vote.exists?(user_id: user.id, votable_id: id, votable_type: 'Sub', value: -1)
  end
end
