shader_type canvas_item;
render_mode unshaded;

uniform float circle_size : hint_range(0.0, 1.2);
uniform float screen_width;
uniform float screen_height;

void fragment() {

	vec2 uv = UV;
	// Centrar las coordenadas
	uv -= vec2(0.5);
	// Corregir la relación de aspecto (hacer que la escala sea uniforme en X e Y)
	uv.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	// Calcular la distancia desde el centro (ajustada)
	float dist = length(uv);
	// Dibujar círculo inverso (alpha 0 adentro, 1 afuera)
	COLOR.a = step(circle_size, dist);
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
