class AddUserRefToHacks < ActiveRecord::Migration
  def change
    add_reference :hacks, :user, index: true, foreign_key: true
  end
end
