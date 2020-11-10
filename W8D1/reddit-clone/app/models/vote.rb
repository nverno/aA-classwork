# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  value        :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Vote < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[votable_id votable_type] }
  belongs_to :votable, polymorphic: true
  belongs_to :user
end
