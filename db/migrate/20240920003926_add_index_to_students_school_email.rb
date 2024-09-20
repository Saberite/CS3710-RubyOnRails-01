class AddIndexToStudentsSchoolEmail < ActiveRecord::Migration[7.1]
  def change
    #Checking for Students to make school email unique
    add_index :students, :school_email,unique:true
  end
end
