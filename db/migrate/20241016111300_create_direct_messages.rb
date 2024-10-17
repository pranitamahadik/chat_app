class CreateDirectMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :direct_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :content

      t.timestamps
    end
  end
end
