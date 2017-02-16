class News < ActiveRecord::Migration[5.0]
  def change
  	add_column :news, :status, :string, default: 0
  end
end
