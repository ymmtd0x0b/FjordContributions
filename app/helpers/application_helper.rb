# frozen_string_literal: true

module ApplicationHelper
  def flash_bg_classes_for(flash_type)
    case flash_type.to_s
    when 'notice' then 'bg-green-500'
    when 'alert'  then 'bg-red-500'
    end
  end

  def flash_icon_classes_for(flash_type)
    case flash_type.to_s
    when 'notice' then 'text-green-500'
    when 'alert'  then 'text-red-500'
    end
  end
end
