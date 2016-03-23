class PatchLinks
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def patch
    links = {
      mainstream_browse_pages: browse_page_ids,
      topics: topic_ids,
    }
    Services.publishing_api.patch_links(resource.content_id, { links: links })
  end

private

  def topic_ids
    additional_topics = resource.additional_topics || []
    primary_topic = resource.primary_topic

    resource.additional_topics = nil
    resource.primary_topic = nil

    additional_topics.unshift(primary_topic).compact
  end

  def browse_page_ids
    browse_pages = resource.browse_pages

    resource.browse_pages = nil

    browse_pages
  end
end
