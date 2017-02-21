class AddIndexDefaultValues < ActiveRecord::Migration[5.0]
  def change
    change_column_null :news, :title, false
    change_column_null :news, :content, false
    change_column_null :news, :channel, false
    change_column_default :news, :channel, 0
    change_column_null :news, :event, false
    change_column_default :news, :event, 0
    change_column_null :news, :tag, false
    change_column_null :news, :status, false
    change_column_default :news, :status, 0
    add_index :news, :channel
  end
end
