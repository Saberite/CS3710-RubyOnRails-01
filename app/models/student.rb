class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



    #Command if no image is uploaded for profile picture
    after_commit :add_default_profile_picture, on: %i[create update]

    
    #Presence = true allows for condiontion to be filied
    validates :first_name, presence:true
    validates :last_name, presence:true
    validates :graduation_date, presence:true
   

    #Sprint #2 VALID_MAJORS
    #Purpose is only accept major listed below
    VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS", 
    "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major"]
    
    #For Before and After
    VALID_BEFOREANDAFTER = ["Before", "After"]
    
    #Major includes validations for text in VALID_MAJORS
    validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}

    
    #Uniqueness: true allows for condiontion to be realized
        #Commented out to remove school_email for email
    #validates :school_email, presence: true 
    #validates :school_email, uniqueness:true
    
    #Documentation at active record validations on guides/rubyonrails.org
    #Format is used to make sure school_email has '@msudenver.edu'
        #Commented out to replace with school_email with email
    #validates :school_email, format: { with: /\A[a-zA-Z0-9]+@msudenver.edu\z/,
    #message: "must be a vaild MSU email" }

    #Active Storage Attachment Associations
    has_one_attached :image

    #Validate email_format for Devise
    validate :email_format
    def email_format
       unless email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
           errors.add(:email, "must be an @msudenver.edu email address")
       end
    end



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
