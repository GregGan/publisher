class PublishedEditionPresenter
  def initialize(edition)
    @edition = edition
    @artefact = edition.artefact
  end

  def render_for_publishing_api(options={})
    {
      title: @edition.title,
      base_path: base_path,
      description: @edition.overview || "",
      schema_name: schema_name,
      document_type: @artefact.kind,
      need_ids: [],
      public_updated_at: public_updated_at,
      publishing_app: "publisher",
      rendering_app: "frontend",
      routes: [
        {path: base_path, type: "exact"}
      ],
      redirects: [],
      update_type: update_type(options),
      details: details,
      locale: 'en',
    }
  end

private

  def base_path
    "/#{@edition.slug}"
  end

  def local_transaction?
    @artefact.kind == 'local_transaction'
  end

  def schema_name
    if local_transaction?
      'placeholder_local_transaction'
    else
      'placeholder'
    end
  end

  def update_type(options)
    if options[:republish]
      "republish"
    elsif major_change?
      "major"
    else
      "minor"
    end
  end

  def major_change?
    @edition.major_change || @edition.version_number == 1
  end

  def public_updated_at
    @edition.public_updated_at || @edition.updated_at
  end

  def details
    base_details = {
      change_note: @edition.latest_change_note,
      tags: {
        browse_pages: @edition.browse_pages,
        primary_topic: primary_topic,
        additional_topics: @edition.additional_topics,
        topics: (primary_topic + @edition.additional_topics)
      },
    }
    if local_transaction?
      base_details.merge(lgsl: @edition.lgsl_code, lgil_override: @edition.lgil_override)
    else
      base_details
    end
  end

  def tags
  end

  def primary_topic
    [@edition.primary_topic].select &:present?
  end
end
