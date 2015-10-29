require 'integration_test_helper'
require 'imminence_areas_test_helper.rb'

class ChangeEditionTypeTest < JavascriptIntegrationTest
  include ImminenceAreasTestHelper

  setup do
    panopticon_has_metadata("id" => "2356")
    stub_collections
    %w(Alice Bob Charlie).each do |name|
      FactoryGirl.create(:user, name: name)
    end
    stub_mapit_areas_requests(Plek.current.find('imminence'))
  end

  teardown do
    GDS::SSO.test_user = nil
  end

  edition_types = [:guide_edition, :programme_edition, :licence_edition, :video_edition, :transaction_edition, :place_edition, :simple_smart_answer_edition, :business_support_edition, :help_page_edition, :campaign_edition, :completed_transaction_edition, :answer_edition]

  sample_parts = Set.new([{"title" => "PART !", "body" => "This is some edition version text.", "slug" => "part-one"}, {"title" => "PART !!", "body" => "This is some more edition version text.", "slug" =>  "part-two"}])

  conversions = edition_types.permutation(2).reject { |pair| pair[0] == pair[1] }

  conversions.each do |pair|

    from, to = pair
    should "be able to convert #{from} into #{to}" do
      edition = FactoryGirl.create(from, state: 'published')
      sample_parts.each {|part| edition.parts.create(part)} if edition.respond_to?(:parts)
      visit_edition edition

      within "div.tabbable" do
        click_on "Admin"
      end

      select(to.to_s.gsub("_", " ").titleize.gsub(/Edition.*/, 'Edition'), from: 'to')

      click_on "Convert"

      assert_text edition.title
      assert_text "New edition created"
      edition_whole_body = edition.whole_body.gsub(/\s+/, " ").strip

      if edition.respond_to?(:parts)
        assert(sample_parts.subset?(Set.new(edition.parts.map { |part| part.attributes.slice("title", "body", "slug") })))
      else
        assert_selector("form#edition-form .tab-pane textarea", text: /\s*#{Regexp.quote(edition_whole_body)}\s*/, visible: true)
      end
    end
  end

  should "be able to convert a Non Parted edition into a ProgrammeEdition and display default parts" do
    edition = FactoryGirl.create(AnswerEdition, state: 'published')
    visit_edition edition

    within "div.tabbable" do
      click_on "Admin"
    end

    select('Programme Edition', from: 'to')

    click_on "Convert"

    assert_text edition.title
    assert_text "New edition created"
    edition_whole_body = edition.whole_body.gsub(/\s+/, " ").strip
    assert_selector("form#edition-form .tab-pane textarea", text: /\s*#{Regexp.quote(edition_whole_body)}\s*/, visible: true)
    assert_text("Overview")
    assert_text("What you'll get")
    assert_text("Eligibility")
    assert_text("How to claim")
    assert_text("Further information")
  end
end
