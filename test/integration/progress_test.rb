require 'integration_test_helper'

class GuideProgressTest < ActionDispatch::IntegrationTest

  test "should update progress of a guide" do
    panopticon_has_metadata("id" => '2356')
    setup_users

    guide = FactoryGirl.create(:guide_edition, panopticon_id: 2356)
    guide.update_attribute(:state, 'ready')

    visit "/admin/guides/#{guide.to_param}"

    click_on 'Untitled part'
    within :css, '#parts div.part:first-of-type' do
      fill_in 'Title', with: 'Part One'
      fill_in 'Body',  with: 'Body text'
      fill_in 'Slug',  with: 'part-one'
    end
    click_on "Save"

    click_on "Fact check"

    within "#send_fact_check_form" do
      fill_in "Comment",       with: "Blah"
      fill_in "Email address", with: "user@example.com"
      click_on "Send"
    end

    wait_until { page.has_content? "Status: Fact check" }

    guide.reload

    assert guide.fact_check?
  end
end
