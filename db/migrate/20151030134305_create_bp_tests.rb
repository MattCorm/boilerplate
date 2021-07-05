class CreateBpTests < ActiveRecord::Migration[4.2]
  def change
    create_table :bp_tests do |t|
      t.string :image
      t.string :pdf
      t.integer :int
      t.json :json
      t.text :markdown
      t.text :text

      t.timestamps
    end
  end
end
