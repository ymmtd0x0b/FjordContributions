# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      site: 'FjordContributions',
      charset: 'utf-8',
      description: 'チーム開発プラクティスでの GitHub 上の取り組みを個人に焦点を当てて可視化できるサービスです。',
      keywords: 'GitHub,Issue,PullRequest,チーム開発プラクティス,フィヨルドブートキャンプ,FBC',
      reverse: true,
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://fjordcontributions.onrender.com',
        image: 'https://fjordcontributions.onrender.com/ogp.png'
      },
      twitter: {
        card: 'summary',
        description: :description,
        image: 'https://fjordcontributions.onrender.com/ogp.png',
        domain: 'https://fjordcontributions.onrender.com'
      }
    }
  end
end
