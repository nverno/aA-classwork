# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord
  validates :topic, presence: true

  has_many :taggings,
           foreign_key: :tag_topic_id,
           class_name: "Tagging"

  has_many :shortened_urls,
           through: :taggings,
           source: :shortened_url

  # Returns 5 most visited links for a TagTopic, along w/ number of clicks
  def popular_links
    shortened_urls
      .joins(:visits)
      .group(:short_url, :long_url)
      .order('COUNT(visits.id) DESC')
      .select(:short_url, :long_url, 'COUNT(visits.id) AS number_visits')
      .limit(5)
  end
end
