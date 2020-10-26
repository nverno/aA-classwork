# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ username: 'Star Wars' }, { username: 'Lord of the Rings' }])
#   Character.create(username: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  u1 = User.create!(username: 'Ricky')
  u2 = User.create!(username: 'Ticky')
  u3 = User.create!(username: 'Tambo')

  Poll.destroy_all
  p1 = Poll.create!(title: 'Who?', author_id: u1.id)
  p2 = Poll.create!(title: 'Why?', author_id: u1.id)
  p3 = Poll.create!(title: 'How?', author_id: u2.id)

  Question.destroy_all
  q1 = Question.create!(poll_id: p1.id, text: 'Who is it?')
  q2 = Question.create!(poll_id: p1.id, text: 'Who does it?')
  q3 = Question.create!(poll_id: p1.id, text: 'Who can change it?')

  q4 = Question.create!(poll_id: p2.id, text: 'Why is it?')
  q5 = Question.create!(poll_id: p2.id, text: 'Why change it?')

  q6 = Question.create!(poll_id: p3.id, text: 'How are you?')

  AnswerChoice.destroy_all
  ac1 = AnswerChoice.create!(question_id: q1.id, text: 'a')
  ac2 = AnswerChoice.create!(question_id: q1.id, text: 'b')
  ac3 = AnswerChoice.create!(question_id: q1.id, text: 'c')
  ac4 = AnswerChoice.create!(question_id: q2.id, text: 'yes')
  ac5 = AnswerChoice.create!(question_id: q2.id, text: 'no')
  ac6 = AnswerChoice.create!(question_id: q3.id, text: '1')

  ac7 = AnswerChoice.create!(question_id: q4.id, text: '1')
  ac8 = AnswerChoice.create!(question_id: q4.id, text: '2')

  Response.destroy_all
  r1 = Response.create!(user_id: u3.id, answer_choice_id: ac1.id)
  r2 = Response.create!(user_id: u3.id, answer_choice_id: ac4.id)
  r3 = Response.create!(user_id: u3.id, answer_choice_id: ac6.id)
  r4 = Response.create!(user_id: u3.id, answer_choice_id: ac8.id)

  r5 = Response.create!(user_id: u2.id, answer_choice_id: ac1.id)

  r6 = Response.create!(user_id: u1.id, answer_choice_id: ac1.id)
end
