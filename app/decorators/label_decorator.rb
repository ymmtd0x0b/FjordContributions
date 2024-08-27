# frozen_string_literal: true

module LabelDecorator
  def border_color
    color_paint = color.paint
    color_paint.paint.light? ? color_paint.darken(30).to_s : color_paint.darken(5).to_s
  end

  def font_color
    color.paint.light? ? '#4d4d4d' : '#f9fafb'
  end
end
