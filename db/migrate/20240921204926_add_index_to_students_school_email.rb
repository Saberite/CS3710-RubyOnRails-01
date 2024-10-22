class AddIndexToStudentsSchoolEmail < ActiveRecord::Migration[7.1]
  def change
    #Sprint 1
    #User Story 2 Requirements: email must be unique
    add_index :students, :school_email, unique:true
  end
end
