# frozen_string_literal: true

module ApplicationHelper
  def tab_to(name, path)
    if path == request.fullpath
      link_to name, path, class: 'inline-block p-4 text-blue-600 border-b-2 border-blue-600 rounded-t-lg active', aria: { current: 'page' }
    else
      link_to name, path, class: 'inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300'
    end
  end
end
