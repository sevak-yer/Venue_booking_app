class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :venue
    validates :date, presence: true
    validates :date, presence: true
    validates :date, presence: true
end