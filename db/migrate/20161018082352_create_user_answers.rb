class CreateUserAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_answers do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
