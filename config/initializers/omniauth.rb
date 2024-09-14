Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

# デザインレビュー用の設定
# レビューが終わり次第削除する
if Rails.env.production?
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    provider: 'github',
    uid: 95903475,
    info: {
      nickname: 'ymmtd0x0b',
      name: 'ヤマモト',
      image: 'https://avatars.githubusercontent.com/u/95903475?v=4'
    }
  )
end
# ここまで
