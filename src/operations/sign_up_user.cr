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
end
