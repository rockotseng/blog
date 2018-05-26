class AddOmniauthToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :provider, :string
    add_column :authors, :uid, :string
  end
end
