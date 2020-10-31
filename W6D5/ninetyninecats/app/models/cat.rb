# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w[red brown yellow orange].freeze

  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, inclusion: %w[M F]
  validates :color, inclusion: { in: COLORS, message: '%{value} is an invalid color' }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end
