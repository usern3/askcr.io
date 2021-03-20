Shrine.configure do |config|
  if Lucky::Env.test?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::Memory.new
  elsif Lucky::Env.development?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::FileSystem.new("tmp", prefix: "assets/uploads")
  else
    client = Awscr::S3::Client.new(ENV["BUCKETEER_AWS_REGION"], ENV["BUCKETEER_AWS_ACCESS_KEY_ID"], ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"], endpoint: "https://bucketeer-7b46713e-bb3a-4b4f-a6f3-36fbd08c6baa.s3.amazonaws.com/public/")
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::S3.new(bucket: ENV["BUCKETEER_BUCKET_NAME"] , client: client, prefix: "public/upload", public: false)
  end
end

# Defines the `Shrine` storage locations for different data types.
module ShrineStorage
  UPLOADS = "uploads"
end

# TRICKY: we patch this because it's not providing the correct download url
class Shrine
  module Storage
    class S3 < Storage::Base
      def url(id : String, **options) : String
        endpoint : String?
        if ep = client.@endpoint
          endpoint = ep.gsub("https://", "")
        end
        presigned_options = Awscr::S3::Presigned::Url::Options.new(
          aws_access_key: ENV["BUCKETEER_AWS_ACCESS_KEY_ID"],
          aws_secret_key: ENV["BUCKETEER_AWS_ACCESS_SECRET_KEY"],
          region: ENV["BUCKETEER_AWS_REGION"] 
          object: "/#{object_key(id)}",
          bucket: bucket,
          host_name: endpoint
        )

        url = Awscr::S3::Presigned::Url.new(presigned_options)
        url.for(:get)
      end
    end
  end
end