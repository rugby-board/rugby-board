class AddTextIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :news, :title
    add_index :news, :content
  end
end
