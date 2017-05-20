class AddAutoIncrement < ActiveRecord::Migration[5.0]
  def change
    change_column :news, :id, :integer, primary_key: true, auto_increment: true
  end
end
