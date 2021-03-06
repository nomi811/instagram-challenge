# Post Model
class Post < ActiveRecord::Base
  belongs_to :user
  validates :image, presence: true
  has_attached_file :image,
                    styles: { thumb: ['500 x 500#', :jpg],
                              original: ['500x500>', :jpg] },
                    convert_options: { thumb: '-quality 75 -strip',
                                       original: '-quality 85 -strip' },
                    storage: :s3,
                    s3_credentials: { access_key_id: ENV['S3_BUCKET'],
                                      secret_access_key: ENV['S3_SECRET_KEY'] },
                    bucket: ENV['AWS_BUCKET']

  validates_attachment :image,
                        presence: true,
                        content_type: { content_type: ['image/jpeg',
                                                       'image/gif',
                                                       'image/png'] },
                        size: { in: 0..500.kilobytes }
end
