require "../src/app"

class ChangeUserRole < LuckyCli::Task
  summary "Enable or disable an existing user as an admin."

  switch :disable, "Disable an existing user as an admin.", shortcut: "-d"
  positional_arg :email,
    "Email of an existing user"
  positional_arg :role,
    "Email of an existing user"

  def call
    user = UserQuery.new.email(email).first?
    return puts "User #{email} is not found.".colorize(:red) unless user

    case role
    when "0"
      new_role = "member"
    when "1"
      new_role = "moderator"
    when "2"
      new_role = "admin"
    when "3"
      new_role = "superadmin"
    end

    if disable?
      if user.role > 0
        SaveUser.update!(user, role: 0)
        puts "User #{email} is no longer an admin.".colorize(:green)
      else
        puts "User #{email} is not an admin.".colorize(:red)
      end
    else
      if user.role == role.to_i
        puts "User #{email} is already a(n) #{new_role}.".colorize(:red)
      else
        SaveUser.update!(user, role: role.to_i)
        puts "User #{email} is now a(n) #{new_role}.".colorize(:green)
      end
    end
  end
end