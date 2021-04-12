class Venue < ApplicationRecord
    has_many :reservations, dependent: :delete_all
    has_many :users, through: :reservations
    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    validates :opening_hour, presence: true
    validates :closing_hour, presence: true
end 