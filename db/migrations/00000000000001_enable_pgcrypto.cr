# class ChangeUserIdToInt32::V20210301220038 < Avram::Migrator::Migration::V1
#   def migrate
#     alter table_for(User) do 
#       change_type id : Int32
#     end
#   end

#   def rollback
#     alter table_for(User) do 
#       change_type : Int64
#     end
#   end
# end