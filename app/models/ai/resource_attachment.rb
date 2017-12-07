# == Schema Information
#
# Table name: ai_resource_attachments
#
#  id                :integer          not null, primary key
#  tweet_resource_id :integer          not null
#  category          :integer          default("website"), not null
#  origin_src        :string(255)      not null
#  query             :text(65535)
#  options           :text(65535)
#
# Indexes
#
#  ai_resource_attachments_resource_and_category_index  (tweet_resource_id,category)
#  index_ai_resource_attachments_on_origin_src          (origin_src)
#

class Ai::ResourceAttachment < ApplicationRecord
  serialize :options, JSON

  enum category: {
    website: 0,
    image: 1,
    video: 2
  }

  belongs_to :tweet_resource, class_name: 'Ai::TweetResource', foreign_key: :tweet_resource_id, required: false
end
