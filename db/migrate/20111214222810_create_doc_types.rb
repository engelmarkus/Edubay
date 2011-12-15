class CreateDocTypes < ActiveRecord::Migration
  def change
    create_table :doc_types do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
