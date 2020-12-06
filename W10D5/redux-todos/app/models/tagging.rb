# == Schema Information
#
# Table name: taggings
#
#  id         :bigint           not null, primary key
#  tag_id     :integer          not null
#  todo_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tagging < ApplicationRecord
  belongs_to :todo
  belongs_to :tag
end
