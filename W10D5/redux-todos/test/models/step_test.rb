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
require 'test_helper'

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
