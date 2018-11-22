class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    "https://res.cloudinary.com/lwsw18ldn/image/upload/v1542893035/Default%20User.jpg"
  end
  # Remove everything else
end
