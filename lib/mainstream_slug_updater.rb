class MainstreamSlugUpdater

  def initialize(old_slug, new_slug, user, logger = nil)
    @old_slug = old_slug.sub(/^\//, '')
    @new_slug = new_slug.sub(/^\//, '')
    @user = user
    @logger = logger || Logger.new(nil)
  end

  attr_reader :user

  def update
    update_slug_on_all_editions
    update_artefact_slug
    reregister_slug_with_panopticon
  end

  def published_edition
    @published_edition ||= editions.find { |e| e.published? }
  end

private
  attr_reader(
    :old_slug,
    :new_slug,
    :logger
  )

  def editions
    @editions ||= Edition.where(slug: old_slug).to_a
  end

  def artefact
    @artefact ||= Artefact.find_by_slug(old_slug)
  end

  def update_slug_on_all_editions
    logger.info "Updating the slug on all Editions"
    editions.each do |e|
      e.slug = new_slug
      e.save(validate: false)
    end
  end

  def update_artefact_slug
    logger.info "Updating the slug on the Artefact"
    artefact.slug = new_slug
    artefact.save_as(user, validate: false)
  end

  def reregister_slug_with_panopticon
    logger.info "Re-registering with panopticon to re-create in search"
    published_edition.register_with_panopticon
  end
end
