class Reservation < ActiveRecord::Base
  belongs_to :device
  #belongs_to :user
  validates_presence_of :time_from, :time_to, :device_id
  validate :time_to_is_after_time_from, :device_is_available
  
  # Prüft, ob die Endzeit der Reservierung nach der Startzeit liegt.
  def time_to_is_after_time_from
    if time_from >= time_to
      errors[:base] << "The reservation's end time is before its start time"
    end
  end
  
  # Prüft, ob das gewählte Gerät im ausgewählten Zeitraum zur Verfügung steht.
  def device_is_available
    reservations = Reservation.find_all_by_device_id(device_id)
    
    reservations.each do |res|
      # Wenn die eingegebene Startzeit zwischen Start- und Endzeit liegt,
      # oder wenn die eingegebene Endzeit zwischen Start- und Endzeit liegt.
      if (time_from >= res.time_from && time_from < res.time_to) || (time_to > res.time_from && time_to <= res.time_to)
        errors[:base] << "Device is not available in the selected time span"
        return
      end
    end
  end
  
end
