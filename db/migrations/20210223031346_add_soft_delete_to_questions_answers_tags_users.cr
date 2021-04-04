class AddSoftDeleteToQuestionsAnswersTagsUsers::V20210223031346 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add soft_deleted_at : Time?
    end
    alter table_for(Question) do
      add soft_deleted_at : Time?
    end
    alter table_for(Answer) do
      add soft_deleted_at : Time?
    end
    alter table_for(Tag) do
      add soft_deleted_at : Time?
    end
  end

  def rollback
    alter table_for(User) do
      remove :soft_deleted_at
    end
    alter table_for(Question) do
      remove :soft_deleted_at
    end
    alter table_for(Answer) do
      remove :soft_deleted_at
    end
    alter table_for(Tag) do
      remove :soft_deleted_at
    end
  end
end
