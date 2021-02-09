class CreateAnswers::V20210202194450 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Answer) do
      primary_key id : Int64
      add_timestamps
      add body : String
      add parsed_body : String
      add solution : Bool, default: false

      add_belongs_to question : Question, on_delete: :restrict
      add_belongs_to author : User, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Answer)
  end
end
