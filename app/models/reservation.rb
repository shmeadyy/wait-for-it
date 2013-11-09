class Reservation < ActiveRecord::Base
  attr_accessible :name, :party_size, :phone_number, :wait_time, :estimated_seat_time

	validates_presence_of :name, :party_size
	validates_numericality_of :party_size, :wait_time

  phony_normalize :phone_number, :default_country_code => 'US'
	validates_plausible_phone :phone_number, :presence => true
	validates_plausible_phone :phone_number, :country_code => '1'

  before_save :add_plus_phone_number, :calculate_seat_time
  after_create :send_text_upon_new_reservation

  def add_plus_phone_number
    self.phone_number = "+" + self.phone_number
  end

  def send_text_upon_new_reservation
    TwilioHelper.send_on_waitlist(self.phone_number,
      "Hi #{self.name}, you've been added to the waitlist. Your wait is approximately #{self.wait_time} minutes.")
  end

  def calculate_seat_time
    comparison_time = Time.now.to_s
    seat_time = Time.now.to_s

    comparison_time_minutes = comparison_time[14..15].to_i
    seat_time_minutes = comparison_time_minutes + self.wait_time
    seat_time_minutes = seat_time_minutes.to_s

    seat_time[14..15] = seat_time_minutes
    self.estimated_seat_time = seat_time.to_time
  end
end
