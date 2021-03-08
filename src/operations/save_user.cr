class SaveUser < User::SaveOperation
  permit_columns username, email, website_url, role, profile_picture_path, email_confirmed_at
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
end
