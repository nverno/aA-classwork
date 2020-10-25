# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :user_id, presence: true
  validates :short_url, uniqueness: true
  validate :no_spamming, :nonpremium_max

  belongs_to :user

  has_many :visits,
           foreign_key: :shortened_url_id,
           class_name: 'Visit'

  has_many :visitors,
           -> { distinct },
           through: :visits,
           source: :user

  has_many :taggings,
           foreign_key: :shortened_url_id,
           class_name: 'Tagging'

  has_many :tag_topics, through: :taggings, source: :tag_topic

  # Limit submitted urls / user to 5 / minute
  def no_spamming
    cnt = user
            .submitted_urls
            .where('created_at > ?', 1.minutes.ago)
            .count

    errors.add(:no_spamming, "can't submit more than 5 urls / minute") if cnt >= 5
  end

  def nonpremium_max
    cnt = user.submitted_urls.count
    errors.add(:nonpremium, 'must upgrade to premium to submit > 5 URLs') if cnt >= 5 && !user.premium
  end

  # Remove shortened URLs that haven't been visited in last (n) minutes
  # and old URLs that have never been visited
  def self.prune(mins)
    # FIXME: not removing unvisited shortened URLs here
    ShortenedUrl
      .joins(:visitors)
      .left_outer_joins(:visits)
      .group(:id)
      .having('COUNT(visits.id) = 0 OR MAX(visits.created_at) < ?', mins.minute.ago)
      .destroy_all
  end

  def self.random_code
    require 'securerandom'
    res = SecureRandom.urlsafe_base64(16)
    res = SecureRandom.urlsafe_base64(16) while ShortenedUrl.exists?(long_url: res)
    res
  end

  def self.create_for_long_url(user, long_url)
    ShortenedUrl.create!(
      user_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def num_clicks
    visits.length
  end

  def num_uniques
    # visits.select(:user_id).distinct.count
    visitors.count
  end

  def num_recent_uniques
    visitors
      .where('visits.created_at > ?', 10.minutes.ago)
      .count
  end
end
