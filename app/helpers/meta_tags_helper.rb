# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: 'FjordContributions',
      charset: 'utf-8',
      description: 'チーム開発プラクティスでの GitHub 上の取り組みを個人に焦点を当てて可視化できるサービスです。',
      keywords: 'GitHub,Issue,PullRequest,チーム開発プラクティス,フィヨルドブートキャンプ,FBC',
      reverse: true
    }
  end
end
