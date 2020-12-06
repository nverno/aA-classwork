# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  title      :string
#  body       :string
#  done       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
class Todo < ApplicationRecord
  validates :title, :body, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :user

  has_many :steps, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag

  def tag_names=(tag_names)
    self.tags = tag_names.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end
end
