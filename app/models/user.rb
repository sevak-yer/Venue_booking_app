class User < ApplicationRecord
    has_secure_password
    has_many :reservations, dependent: :delete_all
    has_many :venues, through: :reservations
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    validates :password_digest, presence: true

    def self.authenticate(username, password)
        find_by_username(username)&.authenticate(password)
    end
end 