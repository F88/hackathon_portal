# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  event_id          :string(255)
#  type              :string(255)
#  title             :string(255)      not null
#  url               :string(255)      not null
#  description       :text(65535)
#  started_at        :datetime         not null
#  ended_at          :datetime         not null
#  limit_number      :integer
#  address           :string(255)      not null
#  place             :string(255)      not null
#  lat               :float(24)
#  lon               :float(24)
#  cost              :integer          default(0), not null
#  max_prize         :integer          default(0), not null
#  currency_unit     :string(255)      default("円"), not null
#  owner_id          :string(255)
#  owner_nickname    :string(255)
#  owner_name        :string(255)
#  attend_number     :integer          default(0), not null
#  substitute_number :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_events_on_event_id_and_type        (event_id,type) UNIQUE
#  index_events_on_started_at_and_ended_at  (started_at,ended_at)
#  index_events_on_title                    (title)
#

class Doorkeeper < Event
  DOORKEEPER_URL = "https://api.doorkeeper.jp/events"

  def self.find_event(keywords:, page: 1)
    http_client = HTTPClient.new
    response = http_client.get(DOORKEEPER_URL, {q: keywords.join("|"), page: page}, {})
    return JSON.parse(response.body)
  end

  def self.import_events!
    page = 1
    update_columns = Connpass.column_names - ["id", "type", "event_id", "created_at"]
    begin
      events_response = Doorkeeper.find_event(keywords: Event::HACKATHON_KEYWORDS + ["はっかそん"], page: page)
      doorkeeper_events = []
      events_response.each do |res|
        event = res["event"]
        doorkeeper_events << Doorkeeper.new(
          event_id: event["id"].to_s,
          title: event["title"].to_s,
          url: event["public_url"].to_s,
          description: ApplicationRecord.basic_sanitize(event["description"].to_s),
          started_at: Time.parse(event["starts_at"]),
          ended_at: Time.parse(event["ends_at"]),
          limit_number: event["ticket_limit"],
          address: event["address"].to_s,
          place: event["venue_name"].to_s,
          lat: event["lat"],
          lon: event["long"],
          cost: 0,
          max_prize: 0,
          currency_unit: "円",
          owner_id: event["group"],
          attend_number: event["participants"],
          substitute_number: event["waitlisted"]
        )
      end
      Doorkeeper.import!(doorkeeper_events)
      page += 1
    end while events_response.present?
  end
end
