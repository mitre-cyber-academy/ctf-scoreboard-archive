class AddDivisionRefToSolvedChallenges < ActiveRecord::Migration
  def change
    add_reference :feed_items, :division, index: true, foreign_key: true
  end
end
