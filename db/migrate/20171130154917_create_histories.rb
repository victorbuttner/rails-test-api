class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :token

      t.timestamps null: false
    end
  end
end
