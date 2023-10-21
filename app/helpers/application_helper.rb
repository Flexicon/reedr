# frozen_string_literal: true

module ApplicationHelper
  DEFAULT_SVG_OPTS = { class: 'w-5 h-5' }.freeze

  def svg(name, opts = {})
    Rails.root.join("app/assets/images/#{name}.svg").to_s.then do |file_path|
      if File.exist?(file_path)
        Rails.cache.fetch("application_helper/svg/#{name}", expires_in: 3.minutes) do
          content_tag(:span, File.read(file_path).html_safe, svg_tag_opts(name, opts)) # rubocop:disable Rails/OutputSafety
        end
      else
        Rails.logger.error("Could not find svg: #{name}.svg")
        '(svg not found)'
      end
    end
  end

  private

  def svg_tag_opts(name, opts = {})
    DEFAULT_SVG_OPTS.merge(opts).tap do |o|
      o[:class] = "icon icon-#{name} #{o[:class]}"
    end
  end
end
