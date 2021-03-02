class AddUpvoteAndDownvotes::V20210301200544 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Vote) do
      primary_key id : Int32
      add_timestamps
      add upvote : Boolean, default: false
      add downvote : Boolean, default: false
      add_belongs_to user : User, on_delete: :cascade
      add_belongs_to question : Questions, on_delete: :cascade
      add_belongs_to answer : Answer, on_delete: :cascade
    end
    create table_for(VoteManager) do
      primary_key id : Int32
      add_timestamps
      add_belongs_to user : User, on_delete: :cascade
      add_belongs_to answer : Answer, on_delete: :cascade
      add_belongs_to question : Question, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Vote)
    drop table_for(VoteManager)
  end
end
