class Student < ApplicationRecord
    validates :first_name, :last_name, :school_email, :major, :graduation_date, presence: true # Values can't be empty

    
    validates :school_email, uniqueness: { case_sensitive: false }   # Email has to be unique.
    validates :school_email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is not a valid email." }
    validates :school_email, format: { with: /\A[\w+\-.]+@msudenver\.edu\z/i, message: "address is not a valid 'username@msudenver.edu' email." }

    has_one_attached :profile_picture, dependent: :purge_later

    VALID_MAJORS = ["Any Major", "Computer Engineering BS", "Computer Information Systems BS",
       "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major"]

    validates :major, inclusion: { in: VALID_MAJORS, message: "%{value} is not a valid major" }

    validate :must_have_search_criteria

    private

    def must_have_search_criteria
        if major.blank? && graduation_date.blank?
            errors.add(:base, "Please select either a Major or enter a Graduation Date.")
        end
    end


end
