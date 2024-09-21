class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    #Student Table(User Story 1)
    create_table :students do |t|
      t.string :name
      t.string :school_email
      t.string :major
      t.string :minor
      t.date :graduation_date

      t.timestamps
      
    end
    #Checking Presence for all fields
    add_index :students, :name,Presence:true
    add_index :students, :school_email,Presence:true, unique:true
    add_index :students, :major,Presence:true
    add_index :students, :minor,Presence:true
    add_index :students, :graduation_date,Presence:true
  end
end
