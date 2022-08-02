// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PixelEffect"
{
	Properties
	{
		_Pixelsx("Pixels x", Range( 0 , 1000)) = 1000
		_PixelsY("Pixels Y", Range( 0 , 1000)) = 1000

	}

	SubShader
	{
		LOD 0

		Cull Off
		ZWrite Off
		ZTest Always
		
		Pass
		{
			CGPROGRAM

			

			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			
		
			struct ASEAttributesDefault
			{
				float3 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				
			};

			struct ASEVaryingsDefault
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
			#if STEREO_INSTANCING_ENABLED
				uint stereoTargetEyeIndex : SV_RenderTargetArrayIndex;
			#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _Pixelsx;
			uniform float _PixelsY;


			
			float2 TransformTriangleVertexToUV (float2 vertex)
			{
				float2 uv = (vertex + 1.0) * 0.5;
				return uv;
			}

			ASEVaryingsDefault Vert( ASEAttributesDefault v  )
			{
				ASEVaryingsDefault o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV (v.vertex.xy);
#if UNITY_UV_STARTS_AT_TOP
				o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex (o.texcoord, 1.0);

				v.texcoord = o.texcoordStereo;
				float4 ase_ppsScreenPosVertexNorm = float4(o.texcoordStereo,0,1);

				

				return o;
			}

			float4 Frag (ASEVaryingsDefault i  ) : SV_Target
			{
				float4 ase_ppsScreenPosFragNorm = float4(i.texcoordStereo,0,1);

				float2 uv04 = i.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float pixelWidth2 =  1.0f / _Pixelsx;
				float pixelHeight2 = 1.0f / _PixelsY;
				half2 pixelateduv2 = half2((int)(uv04.x / pixelWidth2) * pixelWidth2, (int)(uv04.y / pixelHeight2) * pixelHeight2);
				

				float4 color = tex2D( _MainTex, pixelateduv2 );
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18301
89;131;1326;685;866.9005;353.3101;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-623.3998,-188.2;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-706.3383,96.68443;Float;False;Property;_PixelsY;Pixels Y;1;0;Create;True;0;0;False;0;False;1000;1000;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-709.9381,13.38433;Inherit;False;Property;_Pixelsx;Pixels x;0;0;Create;True;0;0;False;0;False;1000;1000;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCPixelate;2;-266.5,85.79999;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;12;-320.6288,-286.7024;Inherit;False;0;0;_MainTex;Pass;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;4.356133,-158.9465;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;11;577.493,48.2;Float;False;True;-1;2;ASEMaterialInspector;0;2;PixelEffect;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;0
WireConnection;2;0;4;0
WireConnection;2;1;5;0
WireConnection;2;2;6;0
WireConnection;14;0;12;0
WireConnection;14;1;2;0
WireConnection;11;0;14;0
ASEEND*/
//CHKSM=325179F30B92D23764D8512030CDC42390245B38