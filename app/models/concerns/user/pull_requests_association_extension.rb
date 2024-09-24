# frozen_string_literal: true

module User::PullRequestsAssociationExtension
  def not_referenced_by_other_users
    sql = <<~"SQL"
      #{not_assigned_by_other_users} AND #{not_reviewed_by_other_users}
    SQL
    sanitized_sql = PullRequest.sanitize_sql_array([sql, { owner_id: proxy_association.owner.id }])
    where(sanitized_sql, owner_id: proxy_association.owner.id)
  end

  private

  def not_assigned_by_other_users
    <<~SQL
      NOT EXISTS (
        SELECT 1
        FROM assigns
        WHERE assigns.assignable_type = 'PullRequest' AND assigns.assignable_id = pull_requests.id AND assigns.user_id != :owner_id
      )
    SQL
  end

  def not_reviewed_by_other_users
    <<~SQL
      NOT EXISTS (
        SELECT 1
        FROM reviews
        WHERE reviews.pull_request_id = pull_requests.id AND reviews.user_id != :owner_id
      )
    SQL
  end
end
