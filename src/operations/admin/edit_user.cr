class Admin::EditUser < User::SaveOperation
  permit_columns username, email, website_url, role, profile_picture_path, email_confirmed_at, btc_address, bch_address, 
                 doge_address, eth_address, oxen_address, xmr_address, nim_address, bio, location, github_username

  file_attribute :profile_picture

  before_save do
    validate_uniqueness_of email
    validate_uniqueness_of username
    validate_size_of username, min: 3  # Can't be too short
    validate_size_of username, max: 14 # Must have a short name
    validate_required role
    profile_picture.value.try { |pic| upload_pic(pic) }
  end
 
  private def upload_pic(pic)
    result = Shrine.upload(File.new(pic.tempfile.path), "store", metadata: {"filename" => pic.filename})
    # If the new file is uploaded, no reason to keep the old one!
    # If multiple models can share an image, run a query before deleting
    # to ensure you're not breaking any references.

    profile_picture_path.value = result.id
  end

  private def delete_old_profile_picture(image_id)
    Shrine::UploadedFile.new(id: image_id, storage_key: "store").delete
  end
end