class AddSlugToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :slug, :string
    add_index :profiles, :slug, unique: true
  end
end
