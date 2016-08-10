class RepublishContent
  def self.schedule_republishing
    Edition.published.each do |edition|
      PublishingAPIRepublisher.new.perform(edition.id.to_s, "republish")
    end
  end
end
