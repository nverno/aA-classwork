# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :sub

  belongs_to :author,
             foreign_key: :author_id,
             class_name: :User

  has_many :post_subs

  has_many :subs,
           through: :post_subs,
           source: :sub

  has_many :comments
  # def sub_ids=(sub_ids)
  #   debugger
  #   sub_ids.each do |_k, s_id|
  #     PostSub.create(sub_id: s_id, post_id: self.id)
  #   end
  # end

  def top_level_comments
    comments.where(parent_comment_id: nil)
  end

  # hash of comments: parent_id => [child_comments]
  def comments_by_parent_id
    h = Hash.new { |hash, k| hash[k] = [] }
    comments.includes(:author).each_with_object(h) do |comment, hash|
      hash[comment.parent_comment_id] << comment
    end
  end
end
