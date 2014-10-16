class CreateWithSecrets < ActiveRecord::Migration
  def change
    create_table :with_secrets do |t|
      t.string :name
      t.string :secret_name

      t.timestamps
    end
  end
end
