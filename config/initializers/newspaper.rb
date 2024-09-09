Rails.configuration.after_initialize do
  Newspaper.subscribe(:user_update, Synchronizer::Repository.new)
  Newspaper.subscribe(:user_update, Synchronizer::Label.new)
  Newspaper.subscribe(:user_update, Synchronizer::CreatedIssue.new)
  Newspaper.subscribe(:user_update, Synchronizer::AssignedIssue.new)
  Newspaper.subscribe(:user_update, Synchronizer::ReviewedIssue.new)
  Newspaper.subscribe(:user_update, Synchronizer::AssignedPullRequest.new)
  Newspaper.subscribe(:user_update, Synchronizer::ReviewedPullRequest.new)
  Newspaper.subscribe(:user_update, Synchronizer::CreatedWiki.new)

  Newspaper.subscribe(:user_destroy, Destroyer::CreatedIssue.new)
  Newspaper.subscribe(:user_destroy, Destroyer::AssignedIssue.new)
  Newspaper.subscribe(:user_destroy, Destroyer::ReviewedIssue.new)
  Newspaper.subscribe(:user_destroy, Destroyer::AssignedPullRequest.new)
  Newspaper.subscribe(:user_destroy, Destroyer::ReviewedPullRequest.new)
end
