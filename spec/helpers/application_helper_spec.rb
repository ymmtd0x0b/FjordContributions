# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#tab_to' do
    context '「引数のパス」が「リクエストされた URL のパス」と"一致する"場合' do
      it 'aタグにアクティブなデザインの CSS クラスを適応する' do
        request_mock = double('request')
        allow(request_mock).to receive(:fullpath).and_return('/current_user/issues')
        allow(helper).to receive(:request).and_return(request_mock)

        actual = helper.tab_to('作成した Issue', current_user_issues_path)
        expect(actual).to have_selector('a[class="inline-block p-4 text-blue-600 border-b-2 border-blue-600 rounded-t-lg active"][aria-current="page"]',
                                        text: '作成した Issue')
      end
    end

    context '「引数のパス」が「リクエストされた URL のパス」と"一致しない"場合' do
      it '非アクティブなデザインの CSS クラスを適応する' do
        request_mock = double('request')
        allow(request_mock).to receive(:fullpath).and_return('/current_user/wikis')
        allow(helper).to receive(:request).and_return(request_mock)

        actual = helper.tab_to('作成した Issue', current_user_issues_path)
        expect(actual).to have_selector('a[class="inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300"]',
                                        text: '作成した Issue')
      end
    end
  end
end
