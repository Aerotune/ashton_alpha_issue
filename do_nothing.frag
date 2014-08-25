#version 110
uniform sampler2D in_Texture;
varying vec2 var_TexCoord;

void main()
{
	 gl_FragColor = texture2D(in_Texture, var_TexCoord);
}