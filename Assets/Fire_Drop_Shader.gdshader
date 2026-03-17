shader_type spatial;

uniform sampler2D Noise_Texture : source_color;
uniform sampler2D Coloring_Texture : source_color;
uniform sampler2D UV_Random : source_color;
uniform sampler2D Alpha_Texture : source_color;
uniform vec2 Speed = vec2(0.2, 0.0);
uniform float Emmision_Power = 1.0;
uniform float Twist_Power = 1.0;

uniform sampler2D Vertex_Noise_Texture;
uniform sampler2D Vertex_Noise_Power_Texture;
uniform float Displace_Power = 0.5;

uniform float Fresnel_Power = 1.0;
uniform float Random_Power = 1.0;
uniform vec3 Fresnel_Color :source_color;


uniform sampler2D Tail_Vertex_Noise_Texture;
uniform sampler2D Tail_Vertex_Noise_Power_Texture;
uniform float Tail_Displace_Power = 0.5;

void vertex(){
	vec2 UV1 = mod(UV + Speed * TIME, 1.0);
	UV1 = mod(UV + vec2(Speed.y) * TIME,1.0);
	//Tail

	float Tail_Noise_Data = texture(Tail_Vertex_Noise_Texture,vec2(UV1.y,UV1.y)).r;
	float Tail_Noise_Power_Data = texture(Tail_Vertex_Noise_Power_Texture,UV).r;
	vec3 Center_Offset = (vec3(-2.0) * Tail_Displace_Power * Tail_Noise_Power_Data ) ;
	VERTEX.xz +=  ((Center_Offset + NORMAL + (Tail_Noise_Data * Tail_Noise_Power_Data)) * Tail_Displace_Power).xz;

}

void fragment() {
	vec2 UV1 = mod(UV + Speed * TIME, 1.0);
	UV1.x = mod(UV1.x + UV1.y * Twist_Power , 1.0);


	vec2 Twisted_UV_For_random = UV * Twist_Power;
	Twisted_UV_For_random.y = fract(Twisted_UV_For_random.y + Speed.x * TIME);
	vec2 Random_UV = (UV + texture(UV_Random,Twisted_UV_For_random ).r * Random_Power) ;

	vec4 Noise = texture(Noise_Texture, UV1);
	vec4 Color_ = texture(Coloring_Texture, Random_UV);

    vec4 Final_Color = Noise * Color_;



	float Fresnel = pow(1.0 - dot(NORMAL, VIEW), Fresnel_Power);

	Final_Color.rgb = mix(Final_Color.rgb,Fresnel_Color,Fresnel);
    ALBEDO = Final_Color.rgb;
	EMISSION = Final_Color.rgb * Emmision_Power;


	float Alpha = texture(Alpha_Texture,UV).a;
	Alpha = clamp(Alpha + Final_Color.a,0.0,1.0);

    ALPHA = Alpha;
}
