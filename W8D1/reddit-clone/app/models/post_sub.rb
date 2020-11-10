# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
  validates :post_id, uniqueness: { scope: :sub_id }
  belongs_to :post
  belongs_to :sub
end
