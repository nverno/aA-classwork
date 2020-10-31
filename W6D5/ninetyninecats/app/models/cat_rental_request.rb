# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: %w[PENDING APPROVED DENIED]
  validate :does_not_overlap_approved_request

  belongs_to :cat

  # Get all requests that overlap
  # returns an ActiveRecord::Relation
  def overlapping_requests
    # SELECT *
    # FROM cat_rental_requests
    # WHERE (
    #   id != #{id} AND
    #   cat_id = #{cat_id} AND
    #   ((#{start_date} BETWEEN start_date AND end_date) OR
    #    (#{end_date} BETWEEN start_date AND end_date))
    # )
    CatRentalRequest
      .where(cat_id: cat_id)
      .where.not(id: id)
      .where.not([<<-SQL, start_date, end_date])
        (? > end_date) OR (? < start_date)
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  # Rental requests can't overlap with another APPROVED rental request
  # for the same cat
  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors.add(:does_not_overlap_approved_request,
                 'cat has been rented during this period')
    end
  end

  def pending?
    status == 'PENDING'
  end

  def approve!
    transaction do
      self.status = 'APPROVED'
      save!

      # reject other overlapping ones
      overlapping_requests.each do |tr|
        next if tr.status == 'DENIED'

        tr.update!(status: 'DENIED')
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    save!
  end
end
