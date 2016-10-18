class AddOwnerToQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    add_reference :questionnaires, :owner, index: true
  end
end
