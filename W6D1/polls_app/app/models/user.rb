# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true

  has_many :authored_polls, foreign_key: :author_id, class_name: 'Poll'
  has_many :responses, foreign_key: :user_id, class_name: 'Response'

  # returns polls where user has answered all of the questions
  def completed_polls
    # Counting questions / poll
    # qs_per_polls = Poll.find_by_sql(<<-SQL)
    #   SELECT polls.*, COUNT(questions.id) AS number_questions
    #   FROM polls
    #   JOIN questions ON polls.id = questions.poll_id
    #   GROUP BY polls.id
    # SQL
    # num_qs.map { |p| p.number_questions }

    # Completed polls by this user
    # num_response = Poll.find_by_sql([<<-SQL, id])
    #   SELECT polls.*
    #   FROM polls
    #   JOIN questions ON polls.id = questions.poll_id
    #   JOIN answer_choices ON answer_choices.question_id = questions.id
    #   LEFT OUTER JOIN (
    #        SELECT *
    #        FROM responses
    #        WHERE responses.user_id = ?) AS responses
    #   ON responses.answer_choice_id = answer_choices.id
    #   GROUP BY polls.id
    #   HAVING COUNT(DISTINCT questions.id) = COUNT(responses.id)
    # SQL
    # num_response.pluck(:title)

    Poll
      .joins(questions: :answer_choices)
      .joins(<<-SQL)
        LEFT OUTER JOIN (
        SELECT * 
        FROM responses 
        WHERE responses.user_id = #{id}
        ) AS responses ON answer_choices.id = responses.answer_choice_id
      SQL
      .group('polls.id')
      .having('COUNT(DISTINCT questions.id) = COUNT(responses.id)')
      .pluck(:title)
  end

  # list of polls started, but not yet completed by this user
  def uncompleted_polls
    res = Poll.find_by_sql([<<-SQL, id])
      SELECT polls.*
      FROM polls
      JOIN questions ON questions.poll_id = polls.id
      JOIN answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
           SELECT *
           FROM responses
           WHERE responses.user_id = ?
      ) AS responses ON responses.answer_choice_id = answer_choices.id
      GROUP BY polls.id
      HAVING COUNT(DISTINCT questions.id) != COUNT(responses.id)
    SQL
    res.pluck(:title)
  end
end
