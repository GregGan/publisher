namespace :publishing_api do
  desc "Republish all content"
  task republish_content: [:environment] do
    puts "Scheduling republishing of #{Edition.published.count} editions"

    RepublishContent.schedule_republishing

    puts "Scheduling finished"
  end
end
