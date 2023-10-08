# frozen_string_literal: true

module ApplicationHelper
  DEFAULT_SVG_OPTS = { class: 'w-5 h-5' }.freeze

  def svg(name, opts = {})
    "#{Rails.root}/app/assets/images/#{name}.svg".then do |file_path|
      if File.exist?(file_path)
        Rails.cache.fetch("application_helper/svg/#{name}", expires_in: 3.minutes) do
          content_tag(:span, File.read(file_path).html_safe, DEFAULT_SVG_OPTS.merge(opts))
        end
      else
        Rails.logger.error("Could not find svg: #{name}.svg")
        '(svg not found)'
      end
    end
  end
end
