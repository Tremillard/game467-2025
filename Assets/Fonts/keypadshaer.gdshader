shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform bool is_on = false;
void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	if(input_color == vec4(0,1,0,1) && is_on == true){
		COLOR = vec4(1,0,0,1);
	}

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
