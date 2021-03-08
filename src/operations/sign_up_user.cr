class SignUpUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations

  permit_columns email, username, website_url, profile_picture_path
  attribute password : String
  attribute password_confirmation : String
  file_attribute :profile_picture

  before_save do
    validate_uniqueness_of email
    validate_uniqueness_of username
    validate_size_of username, min: 3  # Can't be too short
    validate_size_of username, max: 14 # Must have a short name
    validate_required role
    validate_size_of password, min: 7
    Authentic.copy_and_encrypt password, to: encrypted_password
    profile_picture.value.try { |pic| upload_pic(pic) }
  end

  private def upload_pic(pic)
    result = Shrine.upload(File.new(pic.tempfile.path), "store", metadata: {"filename" => pic.filename})
    # If the new file is uploaded, no reason to keep the old one!
    # If multiple models can share an image, run a query before deleting
    # to ensure you're not breaking any references.
    profile_picture_path.value = "/uploads/#{result.id}"
  end

  def send_confirmation_email(user)
    AccountConfirmEmail.new(user).deliver
  end
end
