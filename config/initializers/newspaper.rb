Rails.configuration.after_initialize do
  Newspaper.subscribe(:create_user, Synchronizer::CreatedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::AssignedIssue.new)
end
