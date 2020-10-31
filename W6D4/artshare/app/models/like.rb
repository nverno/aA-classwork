# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  user_id       :integer          not null
#  likeable_type :string
#  likeable_id   :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Like < ApplicationRecord
  validates :user_id, :likeable_type, :likeable_id, presence: true
  validates :likeable_id,
            uniqueness: {
              scope: %i[user_id likeable_type],
              message: 'can only like something once'
            }
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
