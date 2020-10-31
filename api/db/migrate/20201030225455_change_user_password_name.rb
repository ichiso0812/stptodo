class ChangeUserPasswordName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password_digest_, :password_digest
  end
end
