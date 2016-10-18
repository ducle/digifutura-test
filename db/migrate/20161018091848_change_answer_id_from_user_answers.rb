class ChangeAnswerIdFromUserAnswers < ActiveRecord::Migration[5.0]
  def change
    change_column(:user_answers, :answer_id, 'integer USING CAST(answer_id AS integer)')
    add_index :user_answers, :answer_id
  end
end
