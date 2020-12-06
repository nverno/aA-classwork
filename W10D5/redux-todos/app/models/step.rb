# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  todo_id    :integer          not null
#  title      :string           not null
#  body       :string           not null
#  done       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Step < ApplicationRecord
  validates :todo_id, :title, :body, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :todo
end
