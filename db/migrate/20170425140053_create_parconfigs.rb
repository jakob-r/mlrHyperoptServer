class CreateParconfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :parconfigs do |t|
      t.string :user_email, :default => "<anonymous>"
      t.text :json_parconfig
      t.text :json_parvals
      t.string :learner_class
      t.string :learner_type
      t.string :learner_name
      t.integer :download_count, :default => 0
      t.integer :upload_count, :default => 0
      t.boolean :default, :default => false
      t.text :note

      t.timestamps
    end
    execute "ALTER TABLE parconfigs ADD UNIQUE KEY `json_par` (`json_parconfig`,`json_parvals`);"
  end
end
