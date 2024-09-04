Rails.configuration.after_initialize do
  Newspaper.subscribe(:create_user, Synchronizer::Repository.new)
  Newspaper.subscribe(:create_user, Synchronizer::Label.new)
  Newspaper.subscribe(:create_user, Synchronizer::CreatedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::AssignedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::ReviewedIssue.new)
  Newspaper.subscribe(:create_user, Synchronizer::AssignedPullRequest.new)
  Newspaper.subscribe(:create_user, Synchronizer::ReviewedPullRequest.new)
  Newspaper.subscribe(:create_user, Synchronizer::CreatedWiki.new)

  Newspaper.subscribe(:update_user, Synchronizer::Repository.new)
  Newspaper.subscribe(:update_user, Synchronizer::Label.new)
  Newspaper.subscribe(:update_user, Synchronizer::CreatedIssue.new)
  Newspaper.subscribe(:update_user, Synchronizer::AssignedIssue.new)
  Newspaper.subscribe(:update_user, Synchronizer::ReviewedIssue.new)
  Newspaper.subscribe(:update_user, Synchronizer::AssignedPullRequest.new)
  Newspaper.subscribe(:update_user, Synchronizer::ReviewedPullRequest.new)
  Newspaper.subscribe(:update_user, Synchronizer::CreatedWiki.new)

  Newspaper.subscribe(:update_user, Destroyer::CreatedIssue.new)
  Newspaper.subscribe(:update_user, Destroyer::AssignedIssue.new)
  Newspaper.subscribe(:update_user, Destroyer::ReviewedIssue.new)
  Newspaper.subscribe(:update_user, Destroyer::AssignedPullRequest.new)
  Newspaper.subscribe(:update_user, Destroyer::ReviewedPullRequest.new)
end
