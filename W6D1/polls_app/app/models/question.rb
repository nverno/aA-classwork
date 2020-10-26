# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  validates :text, :poll_id, presence: true

  belongs_to :poll, foreign_key: :poll_id, class_name: 'Poll'
  has_many :answer_choices, foreign_key: :question_id, class_name: 'AnswerChoice'
  has_many :responses, through: :answer_choices, source: :responses

  # return hash of choices + counts
  # n+1 version
  def results_n_plus_one
    answer_choices.each_with_object(Hash.new(0)) do |choice, h|
      # n queries here for responses
      h[choice.text] = choice.responses.count
    end
  end

  # remove n+1 queries using includes
  def results_includes
    answer_choices.includes(:responses).each_with_object(Hash.new(0)) do |c, h|
      h[c.text] = c.responses.length
    end
  end

  # Optimized version: no n+1 queries, and avoid transfer of all responses to client
  def results
    # SQL query:
    # SELECT answer_choices.*, COUNT(responses.id) AS counts
    # FROM answer_choices
    # LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id
    # WHERE answer_choices.question_id = self.id
    # GROUP BY answer_choices.id
    res = answer_choices
            .select('answer_choices.*, COUNT(responses.id) AS counts')
            .left_outer_joins(:responses)
            .where(answer_choices: { question_id: id })
            .group('answer_choices.id')

    res.map { |c| [c.text, c.counts] }.to_h
  end
end
