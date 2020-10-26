# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response, :not_poll_author

  belongs_to :respondent, foreign_key: :user_id, class_name: 'User'
  belongs_to :answer_choice, foreign_key: :answer_choice_id, class_name: 'AnswerChoice'

  has_one :question, through: :answer_choice, source: :question

  def not_duplicate_response
    errors.add(:not_duplicate_response, "can't respond to question more than once")\
      if respondent_already_answered?
  end

  # Ensure author of poll can't answer
  def not_poll_author
    errors.add(:not_poll_author, "can't respond to your own poll!")\
      if question.poll.author.id == user_id
  end

  # Find all other (not including this one) responses for same question
  def sibling_responses
    question
      .responses
      .where.not(id: id)
  end

  # Check if any siblings exists with same respondent id (user_id)
  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end
end
