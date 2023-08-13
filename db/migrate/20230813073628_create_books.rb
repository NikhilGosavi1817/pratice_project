class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :number_of_copy
      t.string :status
      t.text :note
      t.integer :likes

      t.timestamps
    end
  end
end
