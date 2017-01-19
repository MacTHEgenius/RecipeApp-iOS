class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name, default: ""
      t.decimal :quantity, default: 0.0
      t.integer :recipe_id

      t.timestamps null: false
    end
    add_index :ingredients, :recipe_id
  end
end
