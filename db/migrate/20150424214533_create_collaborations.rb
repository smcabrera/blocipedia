class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :wiki, index: true
    end
  end
end
