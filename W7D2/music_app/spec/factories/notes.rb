# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note       :text
#
FactoryBot.define do
  factory :note do
    user_id { 1 }
    track_id { 1 }
  end
end
