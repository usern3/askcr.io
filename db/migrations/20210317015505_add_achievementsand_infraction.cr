class AddAchievementsandInfraction::V20210317015505 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Achievement) do
      primary_key id : Int32
      add_timestamps
      add title : String
      add description : String
      add soft_deleted_at : Time?
      add_belongs_to user : User, on_delete: :cascade
    end

    create table_for(Infraction) do
      primary_key id : Int32
      add_timestamps
      add title : String
      add description : String
      add severity : Int32
      add soft_deleted_at : Time?
      add_belongs_to user : User, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Achievement)
    drop table_for(Infraction)
  end
end
