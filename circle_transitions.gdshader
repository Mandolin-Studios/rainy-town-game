shader_type canvas_item;

uniform vec2 center; // = vec2(0.5, 0.5);
uniform vec3 backColor; // = vec3(0.1, 0.1, 0.1);
uniform float progress;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
  float distance = length(UV - center);
  float radius = sqrt(8.0) * abs(progress - 0.5);

  if (distance > radius) {
    COLOR = vec4(backColor, 1.0);
  }
  else {
    if (progress < 0.5) COLOR = vec4(0, 0, 0, 0);
    //else return getToColor(uv);
  }
	//COLOR = texture(TEXTURE, UV);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

// Author: Fernando Kuteken
// License: MIT
