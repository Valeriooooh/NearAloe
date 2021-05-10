shader_type canvas_item;
uniform vec4 flash_color: hint_color = vec4(1);
uniform bool active = false;

void fragment(){
	vec4 previous_color = texture(TEXTURE, UV);
//	flash_color = previous_color
	vec4 white_color = vec4(flash_color.r, flash_color.b, flash_color.g, previous_color.a); //vec4(1.0,1.0,1.0, previous_color.a);
	vec4 new_color = previous_color;
	if (active == true){
		new_color = white_color
	}
	COLOR = new_color;
	
} 