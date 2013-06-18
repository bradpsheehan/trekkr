module PhotoSource

  Instagram.configure do |config|
    config.client_id = ENV['CLIENT_ID']
    config.client_secret = ENV['CLIENT_SECRET']
  end

  def self.fetch_tagged_photos_for(tag)
    results = Instagram.tag_recent_media(tag)
    parse_(results)
    # I actually want to parse through all the results, multiple pages.
    # UNLESS I already have them.

    # example from gem
    # page_1 = Instagram.user_recent_media(777)
    # page_2_max_id = page_1.pagination.next_max_id
    # page_2 = Instagram.user_recent_media(777, :max_id => page_2_max_id ) unless page_2_max_id.nil?
  end

  def self.parse_(results)
    parsed_results = results.collect do |result|
      a = { instagram_id: result.id,
        url: result.images.standard_resolution.url,
        height: result.images.standard_resolution.height,
        username: PhotoSource.get_username(result), #result.caption.from.username,
        text: result.caption.text,
        }
      a.merge!( {location: long_lat(result)} ) if result.location.present?
      a 
    end
    parsed_results
  end

  def self.long_lat(result)
    [result.location.longitude, result.location.latitude]
  end

  def self.get_username(result)
    result.caption.from.username
    # result.caption && result.caption.from && result.caption.from.username ? result.caption.from.username : "unknown"
  end
end
