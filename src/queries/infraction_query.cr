class InfractionQuery < User::BaseQuery
  include Avram::SoftDelete::Query
end
