class CreateMembershipFees < ActiveRecord::Migration
  def self.up
    create_table :membership_fees do |t| 
      t.references :member
      t.string :year
    end 
  end

  def self.down
    drop_table :membership_fees
  end
end
