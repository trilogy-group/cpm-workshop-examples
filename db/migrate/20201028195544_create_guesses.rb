class CreateGuesses < ActiveRecord::Migration[6.0]
  def change
    create_table :guesses do |t|
      t.string :slotone
      t.string :slottwo
      t.string :slotthree
      t.string :slotfour
      t.string :solution
      t.string :guess
      t.integer :guess_count

      t.timestamps
    end
  end
end
