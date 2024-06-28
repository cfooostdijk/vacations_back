class CreateVacations < ActiveRecord::Migration[7.1]
  def change
    create_table :vacations do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :vacation_start
      t.date :vacation_end
      t.string :motive
      t.string :status
      t.string :kind

      t.timestamps
    end
  end
end
