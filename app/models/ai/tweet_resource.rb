# == Schema Information
#
# Table name: ai_tweet_resources
#
#  id                 :integer          not null, primary key
#  type               :string(255)
#  resource_id        :string(255)      not null
#  resource_user_id   :string(255)
#  resource_user_name :string(255)
#  body               :text(65535)      not null
#  mention_user_name  :string(255)
#  reply_id           :string(255)
#  quote_id           :string(255)
#  published_at       :datetime         not null
#  options            :text(65535)
#
# Indexes
#
#  index_ai_tweet_resources_on_published_at          (published_at)
#  index_ai_tweet_resources_on_resource_id_and_type  (resource_id,type) UNIQUE
#

class Ai::TweetResource < ApplicationRecord
  serialize :options, JSON

  has_many :summaries, as: :resource, class_name: 'Ai::ResourceSummary'
  has_many :hashtags, as: :resource, class_name: 'Ai::ResourceHashtag'
  has_many :trigrams, class_name: 'Ai::Trigram', foreign_key: :tweet_resource_id
  has_many :sentences, class_name: 'Ai::ResourceSentence', foreign_key: :tweet_resource_id
  has_many :attachments, class_name: 'Ai::ResourceAttachment', foreign_key: :tweet_resource_id
end
