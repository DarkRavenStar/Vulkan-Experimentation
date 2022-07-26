#version 450

//layout(location = 0) in vec4 fragColor;
layout(location = 0) in vec3 fragColor;
layout(location = 1) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

/*
A combined image sampler descriptor is represented in GLSL by a sampler uniform.
*/
layout(binding = 1) uniform sampler2D texSampler;

void main() {
    //outColor = vec4(fragColor);
    //outColor = vec4(fragColor, 1.0);
    //outColor = vec4(fragTexCoord, 0.0, 1.0);
	/*
	Textures are sampled using the built-in texture function. It takes a sampler and 
	coordinate as arguments. The sampler automatically takes care of the filtering and 
	transformations in the background.
	*/
    outColor = texture(texSampler, fragTexCoord);

	/*
	Try experimenting with the addressing modes by scaling the texture coordinates to 
	values higher than 1. For example, the following fragment shader produces the result 
	in the image below when using VK_SAMPLER_ADDRESS_MODE_REPEAT:
	*/
    //outColor = texture(texSampler, fragTexCoord * 2.0);
	//outColor = vec4(fragColor * texture(texSampler, fragTexCoord).rgb, 1.0);
}