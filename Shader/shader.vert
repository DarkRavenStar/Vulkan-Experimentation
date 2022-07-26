#version 450
//#extension GL_KHR_vulkan_glsl: enable

/*
The inPosition and inColor variables are vertex attributes. 
They're properties that are specified per-vertex in the vertex buffer, 
just like we manually specified a position and color per vertex using 
the two arrays.

Just like fragColor, the layout(location = x) annotations assign indices 
to the inputs that we can later use to reference them. It is important to 
know that some types, like dvec3 64 bit vectors, use multiple slots. 
That means that the index after it must be at least 2 higher:

https://www.khronos.org/opengl/wiki/Layout_Qualifier_(GLSL)
e.g.
layout(location = 0) in dvec3 inPosition;
layout(location = 2) in vec3 inColor;
*/

/*
Note that the order of the uniform, in and out declarations doesn't matter. 
The binding directive is similar to the location directive for attributes. 
We're going to reference this binding in the descriptor layout. The line with 
gl_Position is changed to use the transformations to compute the final position 
in clip coordinates. Unlike the 2D triangles, the last component of the clip 
coordinates may not be 1, which will result in a division when converted to the 
final normalized device coordinates on the screen. This is used in perspective 
projection as the perspective division and is essential for making closer objects 
look larger than objects that are further away.
*/

/*
we can copy the data to a VkBuffer and access it through a uniform buffer 
object descriptor from the vertex shader like this:
*/
layout(binding = 0) uniform UniformBufferObject {
	mat4 model;
    mat4 view;
    mat4 proj;
} ubo;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inTexCoord;
//layout(location = 1) in vec4 inColor;

//layout(location = 0) out vec4 fragColor;
layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragTexCoord;

/*
vec2 positions[3] = vec2[](
    vec2(0.0, -0.5),
    vec2(0.5, 0.5),
    vec2(-0.5, 0.5)
);

vec3 colors[3] = vec3[](
    vec3(1.0, 0.0, 0.0),
    vec3(0.0, 1.0, 0.0),
    vec3(0.0, 0.0, 1.0)
);
*/

void main() {
    //gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
	//fragColor = colors[gl_VertexIndex];
	//gl_Position = vec4(inPosition, 0.0, 1.0);
	gl_Position = ubo.proj * ubo.view * ubo.model * vec4(inPosition, 1.0);
	fragColor = inColor;
	/*
	Just like the per vertex colors, the fragTexCoord values will be smoothly interpolated 
	across the area of the square by the rasterizer. We can visualize this by having the 
	fragment shader output the texture coordinates as colors:
	*/
	fragTexCoord = inTexCoord;
}