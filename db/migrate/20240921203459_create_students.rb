class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    #User Story 1: Create Students with fields for first_name, last_name, school_email, major, and graduation date
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :school_email
      t.string :major
      #Added Minor
      t.string :minor
      t.date :graduation_date

      t.timestamps
    end
  end
end
