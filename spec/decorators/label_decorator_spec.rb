# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LabelDecorator, type: :model do
  describe '#border_color' do
    context 'ラベルの色が明るい場合' do
      it 'より暗く変換して返すこと' do
        label = create(:label, :with_repository, color: '#ffffff')
        decorator_label = ActiveDecorator::Decorator.instance.decorate(label)

        expect(label.color.paint.light?).to be_truthy

        color = label.color
        expect { color = decorator_label.border_color }.to change { color.paint.brightness }.from(255.0).to(179.0)
      end
    end

    context 'ラベルの色が暗い場合' do
      it '少し暗く変換して返すこと' do
        label = create(:label, :with_repository, color: '#555555')
        decorator_label = ActiveDecorator::Decorator.instance.decorate(label)

        expect(label.color.paint.dark?).to be_truthy

        color = label.color
        expect { color = decorator_label.border_color }.to change { color.paint.brightness }.from(85.0).to(72.0)
      end
    end
  end

  describe '#font_color' do
    context 'ラベルの色が明るい場合' do
      it '暗い灰色(#4d4d4d)を返すこと' do
        label = create(:label, :with_repository, color: '#ffffff')
        decorator_label = ActiveDecorator::Decorator.instance.decorate(label)

        expect(decorator_label.color.paint.light?).to be_truthy
        expect(decorator_label.font_color).to eq '#4d4d4d'
      end
    end

    context 'ラベルの色が暗い場合' do
      it '薄い灰色(#f9fafb)を返すこと' do
        label = create(:label, :with_repository, color: '#000000')
        decorator_label = ActiveDecorator::Decorator.instance.decorate(label)

        expect(decorator_label.color.paint.dark?).to be_truthy
        expect(decorator_label.font_color).to eq '#f9fafb'
      end
    end
  end
end
