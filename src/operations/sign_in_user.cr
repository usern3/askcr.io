class SignInUser < Avram::Operation
  param_key :user
  # You can modify this in src/operations/mixins/user_from_email.cr
  include UserFromEmail

  attribute email : String
  attribute password : String

  # Run validations and yields the operation and the user if valid
  def run
    user = user_from_email
    validate_credentials(user)

    if valid?
      user
    else
      nil
    end
  end

  private def validate_credentials(user)
    if user
      unless Authentic.correct_password?(user, password.value.to_s)
        password.add_error "is wrong."
      end
      if user.role.banned?
        email.add_error "has been banned."
      end
    else
      email.add_error "is not in our system."
    end
  end
end
