class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.string :invitee_name
      t.string :invitee_email
      t.boolean :active
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
