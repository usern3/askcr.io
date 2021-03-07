class AddUpvoteAndDownvotes::V20210307211126 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Vote) do
      primary_key id : Int32
      add_timestamps
      add vote : Bool?
    end

    create table_for(VoteManager) do
      primary_key id : Int32
      add_timestamps
      add_belongs_to user : User, on_delete: :cascade, foreign_key_type: Int64
      add_belongs_to vote : Vote, on_delete: :cascade
      add_belongs_to question : Question?, on_delete: :cascade
      add_belongs_to answer : Answer?, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(VoteManager)
    drop table_for(Vote)
  end
end
