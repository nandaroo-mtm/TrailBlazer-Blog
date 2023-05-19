class Post < ApplicationRecord
  belongs_to :category
  paginates_per 2
  # include ImageUploader::Attachment(:image)
  include ImageUploader::Attachment.new(:image)

  def self.to_csv
    attributes = %w{id title content category_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |post|
        csv << attributes.map{ |attr| post.send(attr) }
      end
    end
  end
end
