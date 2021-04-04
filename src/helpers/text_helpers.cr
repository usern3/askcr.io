module TextHelpers
  def user_profile_image_link(user : User)
    user_profile_image_link(user, false)
  end

  # :ditto:
  # This can return the path to the *secondary* image as well.
  def user_profile_image_link(user : User, secondary : Bool?)
    image_path = secondary ? "" : user.profile_picture_path
    if image_path
      Shrine.find_storage(ShrineStorage::UPLOADS).url(image_path.to_s)
    end
  end
end
