# == Schema Information
#
# Table name: taggings
#
#  id               :bigint           not null, primary key
#  tag_topic_id     :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Tagging < ApplicationRecord
  validates :tag_topic_id, :shortened_url_id, presence: true

  belongs_to :tag_topic
  belongs_to :shortened_url
end
