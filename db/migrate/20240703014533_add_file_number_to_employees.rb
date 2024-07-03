class AddFileNumberToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_column :employees, :file_number, :integer
  end
end
