Rails.configuration.after_initialize do
  Newspaper.subscribe(:create_user, Synchronizer::CreatedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::AssignedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::ReviewedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::AssignedPullRequest.new)
  Newspaper.subscribe(:create_user, Synchronizer::ReviewedPullRequest.new)
  Newspaper.subscribe(:create_user, Synchronizer::CreatedWiki.new)
