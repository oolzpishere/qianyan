class CreateAllNineteenAutumnDvds < ActiveRecord::Migration[5.2]
  def change
    create_table :all_nineteen_autumn_dvds do |t|
      t.string :openid, index: true
      t.string :unionid, index: true
      t.string :form, index: true
      t.string :form_name
      t.json :entry
      t.string :gen_code, index: true
      t.string :data_type, index: true # like xml
      t.datetime :form_created_at
      t.datetime :form_updated_at

      t.timestamps
    end
  end
end
