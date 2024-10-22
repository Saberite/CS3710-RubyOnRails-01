require 'rails_helper'

require 'faker' # Make sure the Faker gem is installed
#require 'open-uri' # To open the image URL, only needed if removing images


#Clear database before running
Student.destroy_all # Clear existing records if any

#Iteration 50 times for fake data from faker
50.times do |i|
 student =Student.create!(
   first_name: "First #{i + 1}",
   last_name: "Last #{i + 1}",
   school_email: "student#{i + 1}@msudenver.edu",
   major: Student::VALID_MAJORS.sample, # Assuming you have a VALID_MAJORS constant
   graduation_date: Faker::Date.between(from: 2.years.ago, to: 2.years.from_now)
  
 )

 #Below is optional for sprint 2 if I have the time

  # Generate a unique profile pic based on the student's name
   #profile_picture_url = "https://robohash.org/#{student.first_name.gsub(' ', '')}"
   #profile_picture = URI.open(profile_picture_url)
   #student.profile_picture.attach(io: profile_picture, filename: "#{student.first_name}.jpg")
end

puts "50 students created."
