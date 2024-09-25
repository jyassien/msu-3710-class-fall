class Student < ApplicationRecord
    validates :first_name, :last_name, :school_email, :major, :graduation_date, presence: true # Values can't be empty

    
    validates :school_email, uniqueness: { case_sensitive: false }   # Email has to be unique.
    validates :school_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is not a valid email." }
    validates :school_email, format: { with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "address is not a valid 'username@msudenver.edu' email." }

    has_one_attached :profile_picture

end
