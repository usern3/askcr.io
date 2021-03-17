class EditUser < User::SaveOperation
  needs user : User
  permit_columns username, email, website_url, role, profile_picture_path, email_confirmed_at, btc_address, bch_address,
    doge_address, eth_address, oxen_address, xmr_address, nim_address, bio, location, github_username
  attribute password : String
  attribute new_password : String
  attribute new_password_confirmation : String
  attribute password_changes_success : Bool = false
  file_attribute :profile_picture

  before_save do
    validate_uniqueness_of email
    validate_uniqueness_of username
    validate_size_of username, min: 3  # Can't be too short
    validate_size_of username, max: 14 # Must have a short name
    validate_required role
    validate_user_password
    validate_size_of password, min: 7
    update_password_validations
    profile_picture.value.try { |pic| upload_pic(pic) }
  end

  private def upload_pic(pic)
    result = Shrine.upload(File.new(pic.tempfile.path), "store", metadata: {"filename" => pic.filename})

    if old_picture_path = profile_picture_path.value
      delete_old_profile_picture(old_picture_path)
    end

    profile_picture_path.value = "/uploads/#{result.id}"
  end

  private def delete_old_profile_picture(image_path : String)
    Shrine::UploadedFile.new(id: image_path, storage_key: "store").delete
  end

  private def update_password_validations
    if new_password.value
      validate_required password
      user = UserQuery.find(id.value.not_nil!)
      if Authentic.correct_password?(user, password.value.to_s)
        validate_required new_password, new_password_confirmation
        validate_size_of new_password, min: 7
        validate_confirmation_of new_password, with: new_password_confirmation
        Authentic.copy_and_encrypt new_password, to: encrypted_password
      end
    end
  end

  def validate_user_password
    if password.value
      user = UserQuery.find(id.value.not_nil!)
      if Authentic.correct_password?(user, password.value.to_s)
        password_changes_success.value = true
      else
        password.add_error "was incorrect."
      end
    end
  end
end
