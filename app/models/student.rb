class Student < ApplicationRecord
    #User Story #1, each field must be filled
    #Presence = true allows for condiontion to be filied
    validates :first_name, presence:true
    validates :last_name, presence:true
    validates :major, presence:true
    validates :graduation_date, presence:true
    #Minor does not need to be filled

    #User Story #2, must be a unique email
    #Uniqueness: true allows for condiontion to be realized
    validates :school_email, presence: true 
    validates :school_email, uniqueness:true
    
    #Documentation at active record validations on guides/rubyonrails.org
    
    validates :school_email, format: { with: /\A[a-zA-Z]+@msudenver.deu\z/,
    message: "must be a vaild email" }


end
