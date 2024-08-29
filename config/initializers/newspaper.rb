Rails.configuration.after_initialize do
  Newspaper.subscribe(:create_user, Synchronizer::CreatedIssue.new)
end
