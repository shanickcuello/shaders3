// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Perrila_Puerta MAT"
{
	Properties
	{
		_agarrepuertanormal("agarre puerta normal", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _agarrepuertanormal;
		uniform float4 _agarrepuertanormal_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_agarrepuertanormal = i.uv_texcoord * _agarrepuertanormal_ST.xy + _agarrepuertanormal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _agarrepuertanormal, uv_agarrepuertanormal ) );
			float4 color2 = IsGammaSpace() ? float4(0.5262907,0.5377358,0.06848522,0) : float4(0.2391874,0.2506461,0.005808581,0);
			o.Albedo = color2.rgb;
			o.Metallic = 1.0;
			o.Smoothness = 0.4235294;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
628;156;1053;640;1000.141;249.5024;1;True;False
Node;AmplifyShaderEditor.ColorNode;2;-302.8933,-180.2195;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;False;0.5262907,0.5377358,0.06848522,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-302.8933,41.78052;Inherit;False;Constant;_met;met;1;0;Create;True;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-351.6932,156.3804;Inherit;False;Constant;_Rough;Rough;1;0;Create;True;0;0;False;0;False;0.4235294;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-630.9689,-49.22903;Inherit;True;Property;_agarrepuertanormal;agarre puerta normal;0;0;Create;True;0;0;False;0;False;-1;0e096ff3d2565684aa165f3fe149e7cd;0e096ff3d2565684aa165f3fe149e7cd;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;119.6,-52;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Perrila_Puerta MAT;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;2;0
WireConnection;0;1;1;0
WireConnection;0;3;3;0
WireConnection;0;4;4;0
ASEEND*/
//CHKSM=67D99E1C23321BA24D171F66ADD97FEF90F54962