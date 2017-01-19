class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :count
      t.string :description, default: ""
      t.integer :recipe_id

      t.timestamps null: false
    end
    add_index :steps, :recipe_id
  end
end
