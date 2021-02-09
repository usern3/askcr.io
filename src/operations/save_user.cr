class SaveUser < User::SaveOperation
  permit_columns username, email, website_url, role, profile_picture_path
  attribute password : String
  attribute password_confirmation : String
  file_attribute :profile_picture

  before_save do
    validate_uniqueness_of email
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
