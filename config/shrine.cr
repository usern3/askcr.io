Shrine.configure do |config|
  if Lucky::Env.test?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::Memory.new
  elsif Lucky::Env.test?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::FileSystem.new("tmp", prefix: "assets/uploads")
  else
    client = Awscr::S3::Client.new(ENV["BUCKETEER_AWS_REGION"], ENV["BUCKETEER_AWS_ACCESS_KEY_ID"], ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"], endpoint: "https://bucketeer-7b46713e-bb3a-4b4f-a6f3-36fbd08c6baa.s3.amazonaws.com/public/")
    storage = Shrine::Storage::S3.new(bucket: ENV["BUCKETEER_BUCKET_NAME"], client: client, prefix: "public", public: true)
    config.storages["store"] = storage
  end
end
# Defines the `Shrine` storage locations for different data types.
module ShrineStorage
  UPLOADS = "uploads"
end

