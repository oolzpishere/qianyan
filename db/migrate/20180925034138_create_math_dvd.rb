class CreateMathDvd < ActiveRecord::Migration[5.2]
  def change
    create_table :math_dvds do |t|
      t.string :openid
      t.string :unionid
      t.string :form
      t.string :form_name
      t.json :entry
      t.string :gen_code
      t.string :data_type # like xml
      t.datetime :form_created_at
      t.datetime :form_updated_at

      t.timestamps
    end

    add_index :math_dvds, :openid
    add_index :math_dvds, :data_type
    add_index :math_dvds, :unionid
    add_index :math_dvds, :form
    add_index :math_dvds, :gen_code
  end
end
