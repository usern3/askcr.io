class UserQuery < User::BaseQuery
  include Avram::SoftDelete::Query
end
