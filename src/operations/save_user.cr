class SaveUser < User::SaveOperation
  permit_columns username, email, website_url, role, profile_picture_path, email_confirmed_at, btc_address, bch_address,
    doge_address, eth_address, oxen_address, xmr_address, nim_address, bio, location, github_username
  attribute password : String
  attribute password_confirmation : String
  file_attribute :profile_picture

  after_save log_changes

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

    if old_picture_path = profile_picture_path.value
      delete_old_profile_picture(old_picture_path)
    end

    profile_picture_path.value = result.id
  end

  private def delete_old_profile_picture(image_path : String)
    Shrine::UploadedFile.new(id: image_path, storage_key: "store").delete
  end

  def log_changes(user : User)
    # Get changed attributes and log each of them
    attributes.select(&.changed?).each do |attribute|
      Log.dexter.info do
        {
          user_id:           user.id,
          changed_attribute: attribute.name.to_s,
          from:              attribute.original_value.to_s,
          to:                attribute.value.to_s,
        }
      end
    end
  end
end
