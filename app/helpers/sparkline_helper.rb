
# app/helpers/sparkline_helper.rb
module SparklineHelper
  def sparkline(values, width: 100, height: 24, color: "#4f46e5")
    return "" if values.blank?
    max = values.max.to_f.nonzero? || 1.0
    step = width.to_f / [values.size - 1, 1].max
    points = values.each_with_index.map { |v, i|
      x = (i * step).round(2)
      y = (height - (v.to_f / max * height)).round(2)
      "#{x},#{y}"
    }.join(" ")
    <<~SVG.html_safe
      <svg width="#{width}" height="#{height}" viewBox="0 0 #{width} #{height}" class="inline-block align-middle">
        <polyline fill="none" stroke="#{color}" stroke-width="2" points="#{points}" />
      </svg>
    SVG
  end
end
