class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :issue
      t.string :category
      t.string :ref
      t.string :tags
      t.string :solution

      t.timestamps
    end
  end
end
