# frozen_string_literal: true

class HttpUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.present? && compliant?(value)

    record.errors.add(attribute, (options[:message] || 'is not a valid HTTP URL'))
  end

  private

  def compliant?(value)
    URI.parse(value).then { |uri| uri.is_a?(URI::HTTP) && uri.host.present? }
  rescue URI::InvalidURIError
    false
  end
end
