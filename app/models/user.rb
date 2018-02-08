class User < ApplicationRecord
	has_many :events, :foreign_key => :creator_id
	has_many :invitations, :foreign_key => :attendee_id
	has_many :attended_events, :through => :invitations
	has_secure_password
	validates :name, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true

	def upcoming_events
		attended_events.where("date > ?", Time.now)
	end

	def previous_events
		attended_events.where("date < ?", Time.now)
	end
end
