class ChatboxMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chatbox_messages do |t|
      t.integer :messenger
      t.integer :receiver
      t.text :message
      t.references :house
      t.timestamps
    end
  end
end