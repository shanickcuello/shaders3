// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Puerta"
{
	Properties
	{
		_Normalpuerta("Normal puerta", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normalpuerta;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (3.26).xx;
			float2 uv_TexCoord2 = i.uv_texcoord * temp_cast_0;
			o.Normal = UnpackScaleNormal( tex2D( _Normalpuerta, uv_TexCoord2 ), 1.55 );
			float4 color6 = IsGammaSpace() ? float4(0.2075472,0.08609407,0.0264329,0) : float4(0.03550519,0.00799862,0.00204589,0);
			o.Albedo = color6.rgb;
			o.Smoothness = 0.3967599;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
863;154;1053;640;1105.999;531.7828;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;3;-812.4648,40.53149;Inherit;False;Constant;_Float2;Float 1;1;0;Create;True;0;0;False;0;False;3.26;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-555.9572,-55.71572;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-472.938,-496.9213;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;False;0.2075472,0.08609407,0.0264329,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;13;-558.699,-276.9828;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;1;-242.9606,-80.42121;Inherit;True;Property;_Normalpuerta;Normal puerta;0;0;Create;True;0;0;False;0;False;-1;bdc6cbfe39c687f41b159d727eda6dc2;bdc6cbfe39c687f41b159d727eda6dc2;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.55;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-230.213,207.489;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;False;0.3967599;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-209.845,-339.0656;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;198,-115;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Puerta;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;3;0
WireConnection;1;1;2;0
WireConnection;12;0;6;0
WireConnection;12;1;13;0
WireConnection;12;2;13;2
WireConnection;0;0;6;0
WireConnection;0;1;1;0
WireConnection;0;4;10;0
ASEEND*/
//CHKSM=801388D2F640AAB0D8146FCDE2E55DD10E5D0D29