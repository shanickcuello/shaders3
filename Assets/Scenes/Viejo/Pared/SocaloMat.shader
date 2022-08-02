// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SocaloMat"
{
	Properties
	{
		_NormalScratch("Normal Scratch", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalScratch;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (13.56).xx;
			float2 uv_TexCoord4 = i.uv_texcoord * temp_cast_0;
			o.Normal = UnpackNormal( tex2D( _NormalScratch, uv_TexCoord4 ) );
			float4 color1 = IsGammaSpace() ? float4(0.08490568,0.08490568,0.08490568,0) : float4(0.007837884,0.007837884,0.007837884,0);
			o.Albedo = color1.rgb;
			o.Metallic = 0.7016698;
			o.Smoothness = 0.7071634;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
823;164;1053;640;855.4324;292.199;1.447758;True;False
Node;AmplifyShaderEditor.RangedFloatNode;5;-659.1741,-155.8125;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;False;13.56;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-441.7741,-101.4125;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-369.1741,141.7875;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-177.3,-225.5;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;False;0.08490568,0.08490568,0.08490568,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-138.7578,209.1883;Inherit;False;Constant;_Metalic;Metalic;1;0;Create;True;0;0;False;0;False;0.7016698;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-50.75795,341.9883;Inherit;False;Constant;_Roughness;Roughness;1;0;Create;True;0;0;False;0;False;0.7071634;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-153.3978,-42.13271;Inherit;True;Property;_NormalScratch;Normal Scratch;0;0;Create;True;0;0;False;0;False;-1;a51cd0d1ebac31c4398e9175f487b6b0;a51cd0d1ebac31c4398e9175f487b6b0;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;713.0016,-146.1443;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SocaloMat;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;5;0
WireConnection;2;1;4;0
WireConnection;0;0;1;0
WireConnection;0;1;2;0
WireConnection;0;3;6;0
WireConnection;0;4;7;0
ASEEND*/
//CHKSM=F277DFB95F395CDA273451B6D6E404BC28531FE3