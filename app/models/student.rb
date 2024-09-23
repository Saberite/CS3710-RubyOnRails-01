class Student < ApplicationRecord
    #Command if no image is uploaded for profile picture
    after_commit :add_default_profile_picture, on: %i[create update]

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
    #Format is used to make sure school_email has '@msudenver.edu'
    validates :school_email, format: { with: /\A[a-zA-Z0-9]+@msudenver.edu\z/,
    message: "must be a vaild MSU email" }

    #Active Storage Attachment Associations
    has_one_attached :image

    #Default Profile Picture set if not uploaded
    private
    def add_default_profile_picture
        unless image.attached?
            image.attach(
                io: File.open(
                    Rails.root.join(
                        'app', 'assets', 'images', 'Default_Profile_picture.jpg'
                    )
                ), 
                filename: 'Default_Profile_picture.jpg',
                content_type: 'image/jpg'
            )
        end
    end
end
