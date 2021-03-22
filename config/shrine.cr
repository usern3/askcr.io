Shrine.configure do |config|
  if Lucky::Env.test?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::Memory.new
  elsif Lucky::Env.test?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::FileSystem.new("tmp", prefix: "assets/uploads")
  else
    client = Awscr::S3::Client.new(ENV["BUCKETEER_AWS_REGION"], ENV["BUCKETEER_AWS_ACCESS_KEY_ID"], ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"])
    storage = Shrine::Storage::S3.new(bucket: ENV["BUCKETEER_BUCKET_NAME"], client: client, prefix: "public", public: true)
    config.storages[ShrineStorage::UPLOADS] = storage
  end
end
# Defines the `Shrine` storage locations for different data types.
module ShrineStorage
  UPLOADS = "uploads"
end

