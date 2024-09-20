class Student < ApplicationRecord
    #School email must be vaild and unique
    validates :school_email, presence:true, uniqueness:true
    #First name must not be nil or null
    validates :first_name, presence: true
    
end
