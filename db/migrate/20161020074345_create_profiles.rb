class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :suburb
      t.string :postcode
      t.string :state
      t.string :country
      t.string :phone
      t.string :photo
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
