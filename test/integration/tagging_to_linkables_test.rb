require 'integration_test_helper'

class TaggingToLinkablesTest < JavascriptIntegrationTest
  setup do
    setup_users
    stub_linkables
  end

  test "Tagging to browse pages" do
    edition = FactoryGirl.create(:guide_edition)
    content_id = edition.artefact.content_id
    stub_no_links(content_id)

    visit edition_path(edition)
    switch_tab 'Tagging'
    selectize ['Tax / VAT', 'Tax / RTI (draft)'], 'Mainstream browse pages'

    save_tags_and_assert_success
    assert_publishing_api_patch_links(
      content_id,
      {
        links: {
          topics: [],
          mainstream_browse_pages: ["CONTENT-ID-VAT", "CONTENT-ID-RTI"],
          parent:[]
        },
        previous_version: 0
      }
    )
  end

  test "Tagging to topics" do
    edition = FactoryGirl.create(:guide_edition)
    content_id = edition.artefact.content_id
    stub_no_links(content_id)

    visit edition_path(edition)
    switch_tab 'Tagging'

    select 'Oil and Gas / Wells', from: 'Parent'
    select 'Oil and Gas / Fields', from: 'Topics'
    select 'Oil and Gas / Distillation (draft)', from: 'Topics'

    save_tags_and_assert_success
    assert_publishing_api_patch_links(
      content_id,
      {
        links: {
          topics: ['CONTENT-ID-DISTILL', 'CONTENT-ID-FIELDS'],
          mainstream_browse_pages: [],
          parent:['CONTENT-ID-WELLS']
        },
        previous_version: 0
      }
    )
  end
end
