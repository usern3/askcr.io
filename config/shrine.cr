Shrine.configure do |config|
  if Lucky::Env.test?
    config.storages["cache"] = Storage::FileSystem.new("uploads", prefix: "cache")
    config.storages["store"] = Storage::FileSystem.new("uploads")
  elsif Lucky::Env.test?
    config.storages["cache"] = Storage::FileSystem.new("uploads", prefix: "cache")
    config.storages["store"] = Storage::FileSystem.new("uploads")
  else
    client = Awscr::S3::Client.new(ENV["BUCKETEER_AWS_REGION"], ENV["BUCKETEER_AWS_ACCESS_KEY_ID"], ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"])
    storage = Shrine::Storage::S3.new(bucket: ENV["BUCKETEER_BUCKET_NAME"] , client: client, prefix: "public/uploads", public: true)
    config.storages["cache"] = Storage::FileSystem.new("uploads", prefix: "cache")
    config.storages["store"] = storage
  end
end
