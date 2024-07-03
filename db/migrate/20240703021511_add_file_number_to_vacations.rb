class AddFileNumberToVacations < ActiveRecord::Migration[7.1]
  def change
    add_column :vacations, :file_number, :integer
  end
end
