// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ParedMat"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_NormalBricks("Normal Bricks", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _NormalBricks;
		uniform sampler2D _TextureSample0;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (20.0).xx;
			float2 uv_TexCoord10 = i.uv_texcoord * temp_cast_0;
			o.Normal = UnpackScaleNormal( tex2D( _NormalBricks, uv_TexCoord10 ), 1.96 );
			float3 ase_worldPos = i.worldPos;
			float4 color21 = IsGammaSpace() ? float4(0.1372549,0.3623925,0.3960784,0) : float4(0.01680738,0.1080193,0.1301365,0);
			float4 color13 = IsGammaSpace() ? float4(0.1415094,0.1415094,0.1415094,0) : float4(0.01771389,0.01771389,0.01771389,0);
			o.Albedo = ( ( ase_worldPos.y * color21 * 0.02470587 ) + color13 ).rgb;
			o.Metallic = 0.1013062;
			o.Smoothness = 0.4205791;
			float2 temp_cast_2 = (20.0).xx;
			float2 uv_TexCoord19 = i.uv_texcoord * temp_cast_2;
			o.Occlusion = tex2D( _TextureSample0, uv_TexCoord19 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
863;154;1053;640;1926.937;748.4806;2.106123;True;False
Node;AmplifyShaderEditor.CommentaryNode;27;-1270.894,-348.845;Inherit;False;952.0988;471.4218;normal;4;3;2;10;1;;0.4716981,0.3003738,0.3003738,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;26;-338.4678,-1131.953;Inherit;False;792.0522;753.4909;color;6;20;21;25;22;13;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-288.4678,-713.9345;Inherit;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;False;0.02470587;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-256.9854,-900.2494;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;False;0;False;0.1372549,0.3623925,0.3960784,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;20;-198.5342,-1081.953;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;18;-354.002,491.4974;Inherit;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1220.894,-202.5978;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-964.3864,-298.845;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;28.75023,-899.4707;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;13;-268.8774,-621.5314;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;False;0.1415094,0.1415094,0.1415094,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-97.49451,395.2501;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-844.6445,7.576744;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;False;1.96;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-639.7951,-121.3417;Inherit;True;Property;_NormalBricks;Normal Bricks;5;0;Create;True;0;0;False;0;False;-1;f353fb7ea65f81d4cb97922968c4bba1;f353fb7ea65f81d4cb97922968c4bba1;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;218.5844,-631.462;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;17;266.6436,427.4046;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;False;-1;None;f353fb7ea65f81d4cb97922968c4bba1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;201.7937,307.0409;Inherit;False;Constant;_Rough;Rough;1;0;Create;True;0;0;False;0;False;0.4205791;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-100.3721,237.408;Inherit;False;Constant;_Metalic;Metalic;1;0;Create;True;0;0;False;0;False;0.1013062;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;635.7779,-91.98221;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;ParedMat;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;3;0
WireConnection;22;0;20;2
WireConnection;22;1;21;0
WireConnection;22;2;25;0
WireConnection;19;0;18;0
WireConnection;1;1;10;0
WireConnection;1;5;2;0
WireConnection;23;0;22;0
WireConnection;23;1;13;0
WireConnection;17;1;19;0
WireConnection;0;0;23;0
WireConnection;0;1;1;0
WireConnection;0;3;15;0
WireConnection;0;4;16;0
WireConnection;0;5;17;0
ASEEND*/
//CHKSM=87E03140BF84EC92A461C62ACD18184DC1E40762