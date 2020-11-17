class ChangeApprovedInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :bookings, :approved, from: nil, to: false
  end
end
