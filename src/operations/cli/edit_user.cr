class CLI::EditUser < User::SaveOperation
  permit_columns email, role

end
