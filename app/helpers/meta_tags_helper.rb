# frozen_string_literal: true

module MetaTagsHelper
  HOST_NAME = ENV.fetch('HOST_NAME')

  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      site: 'FjordContributions',
      charset: 'utf-8',
      description: 'フィヨルドブートキャンプのチーム開発プラクティスで、あなたが関わった Issue や PullRequest を自動で取得して一覧表示できるサービスです。',
      keywords: 'GitHub,Issue,PullRequest,チーム開発プラクティス,フィヨルドブートキャンプ,FBC',
      reverse: true,
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url:,
        image:
      },
      twitter: {
        card: 'summary',
        description: :description,
        image:,
        domain: url
      }
    }
  end

  private

  def url
    @url ||= URI::HTTPS.build({ host: HOST_NAME }).to_s
  end

  def image
    @image ||= URI::HTTPS.build({ host: HOST_NAME, path: '/ogp.png' }).to_s
  end
end
