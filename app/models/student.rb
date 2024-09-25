class Student < ApplicationRecord
    validates :first_name, :last_name, :school_email, :major, :graduation_date, presence: true # Values can't be empty

    
    validates :school_email, uniqueness: true   #Email has to be unique.

end
