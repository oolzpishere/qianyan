class CreateChinese2019Dvds < ActiveRecord::Migration[5.2]
  def change
    create_table :chinese_2019_dvds do |t|
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

    add_index :chinese_2019_dvds, :openid
    add_index :chinese_2019_dvds, :data_type
    add_index :chinese_2019_dvds, :unionid
    add_index :chinese_2019_dvds, :form
    add_index :chinese_2019_dvds, :gen_code
  end
end
