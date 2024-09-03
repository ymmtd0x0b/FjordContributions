# frozen_string_literal: true

module User::IssuesAssociationExtension
  def not_referenced_by_other_users
    sql = <<~"SQL"
      #{not_created_by_other_users}
    SQL
    where(sql, owner_id: proxy_association.owner.id)
  end

  private

  def not_created_by_other_users
    <<~SQL
      NOT EXISTS (
        SELECT 1
        FROM users
        WHERE issues.author_id = users.id AND issues.author_id != :owner_id
      )
    SQL
  end
end
