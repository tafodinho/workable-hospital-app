class CreatePatientRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_registrations do |t|
      t.references :patient, null: false, foreign_key: true
      t.datetime :registered_at

      t.timestamps
    end
  end
end
