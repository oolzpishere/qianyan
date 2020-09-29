class CreateActivedCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :actived_codes do |t|
      t.belongs_to :subject, index: true
      t.string :code, index: true
      t.string :token

      t.timestamps
    end
  end
end
