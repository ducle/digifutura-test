class CreateUserQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_quizzes do |t|
      t.references :user, foreign_key: true
      t.references :questionnaire, foreign_key: true
      t.datetime :start_time

      t.timestamps
    end
  end
end
