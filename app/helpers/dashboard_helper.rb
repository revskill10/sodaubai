module DashboardHelper
	 def darken_color(hex_color, amount=0.4)
hex_color = hex_color.gsub('#','')
rgb = hex_color.scan(/../).map {|color| color.hex}
rgb[0] = (rgb[0].to_i * amount).round
rgb[1] = (rgb[1].to_i * amount).round
rgb[2] = (rgb[2].to_i * amount).round
"#%02x%02x%02x" % rgb
end
# Amount should be a decimal between 0 and 1. Higher means lighter
def lighten_color(hex_color, amount=0.6)
hex_color = hex_color.gsub('#','')
rgb = hex_color.scan(/../).map {|color| color.hex}
rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
"#%02x%02x%02x" % rgb
end
	def contrasting_text_color(hex_color)
	  color = hex_color.gsub('#','')
	  convert_to_brightness_value(color) > 382.5 ? darken_color(color) : lighten_color(color)
	end
	def convert_to_brightness_value(hex_color)
	  (hex_color.scan(/../).map {|color| color.hex}).sum
	end
end
