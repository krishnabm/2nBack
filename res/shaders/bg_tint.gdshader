shader_type canvas_item;

uniform bool tintShift = false;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	
	if (tintShift) {
		COLOR = vec4(pixelColor.b , pixelColor.r , (pixelColor.r + pixelColor.g)/2.0, pixelColor.a);
		
	} else {
		COLOR = pixelColor;
	}
}