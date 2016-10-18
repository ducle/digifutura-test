class RenameAnswerFromUserAnswers < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_answers, :answer, :answer_id
  end
end
