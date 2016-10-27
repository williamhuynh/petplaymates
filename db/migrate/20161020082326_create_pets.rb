class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.string :size
      t.string :photo
      t.text :availability
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
