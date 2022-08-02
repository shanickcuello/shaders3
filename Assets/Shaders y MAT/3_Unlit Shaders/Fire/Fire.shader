// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fire"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (97.88236,43.04774,2.562366,0)
		_Distortion("Distortion", Range( 0 , 0.5)) = 0.1054148
		_DissolveSpeed("Dissolve Speed", Vector) = (-0.1,-0.5,0,0)
		_DistorcionSpeed("Distorcion Speed", Vector) = (0,-0.3,0,0)
		_DistortionScale("Distortion Scale", Float) = 1.17
		_Dissolvescale("Dissolve scale", Float) = 3.36
		_DissolveAmount("Dissolve Amount", Float) = 0.45
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample0;
		uniform float2 _DistorcionSpeed;
		uniform float _DistortionScale;
		uniform float _Distortion;
		uniform float _Dissolvescale;
		uniform float2 _DissolveSpeed;
		uniform float _DissolveAmount;
		uniform float _Cutoff = 0.5;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float2 voronoihash39( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi39( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash39( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TexCoord28 = i.uv_texcoord * float2( 2,2 ) + ( _DistorcionSpeed * _Time.y );
			float simplePerlin2D24 = snoise( uv_TexCoord28*_DistortionScale );
			simplePerlin2D24 = simplePerlin2D24*0.5 + 0.5;
			float2 temp_cast_0 = (simplePerlin2D24).xx;
			float2 lerpResult32 = lerp( i.uv_texcoord , temp_cast_0 , _Distortion);
			float time39 = -0.17;
			float2 uv_TexCoord35 = i.uv_texcoord + ( _DissolveSpeed * _Time.y );
			float2 coords39 = uv_TexCoord35 * _Dissolvescale;
			float2 id39 = 0;
			float2 uv39 = 0;
			float voroi39 = voronoi39( coords39, time39, id39, uv39, 0 );
			float4 temp_output_23_0 = ( _Color0 * ( tex2D( _TextureSample0, lerpResult32 ) * ( simplePerlin2D24 * pow( voroi39 , _DissolveAmount ) ) ) );
			o.Emission = temp_output_23_0.rgb;
			o.Alpha = 1;
			clip( temp_output_23_0.r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
747;201;1053;601;1081.653;719.1517;2.561837;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;29;-1683.452,382.451;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;30;-1752.003,207.8312;Inherit;False;Property;_DistorcionSpeed;Distorcion Speed;6;0;Create;True;0;0;False;0;False;0,-0.3;0,-0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;37;-1773.937,608.5085;Inherit;False;Property;_DissolveSpeed;Dissolve Speed;5;0;Create;True;0;0;False;0;False;-0.1,-0.5;-0.1,-0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1506.602,633.5094;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1476.162,282.1379;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;25;-1429.752,-2.690254;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;False;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-1341.844,632.3631;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;-1065.865,757.0967;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;False;-0.17;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1250.904,216.2915;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-1067.165,842.8964;Inherit;False;Property;_Dissolvescale;Dissolve scale;8;0;Create;True;0;0;False;0;False;3.36;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1164.988,393.4991;Inherit;False;Property;_DistortionScale;Distortion Scale;7;0;Create;True;0;0;False;0;False;1.17;1.69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-620.6272,812.3528;Inherit;False;Property;_DissolveAmount;Dissolve Amount;9;0;Create;True;0;0;False;0;False;0.45;0.63;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-891.5368,512.4346;Inherit;False;Property;_Distortion;Distortion;4;0;Create;True;0;0;False;0;False;0.1054148;0.1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-985.6968,-42.94715;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;39;-822.7643,664.7964;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.NoiseGeneratorNode;24;-956.4228,157.3626;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;32;-523.7303,163.0939;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;42;-426.0573,674.6541;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-148.4272,573.3528;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;6.329199,96.45417;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;False;-1;21da68038f8352f489888ba105453c70;21da68038f8352f489888ba105453c70;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;357.2562,298.1019;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;22;117.561,-381.5386;Inherit;False;Property;_Color0;Color 0;3;1;[HDR];Create;True;0;0;False;0;False;97.88236,43.04774,2.562366,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;211.0049,-612.4203;Inherit;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;False;0;False;-1;5dc12c55c5128854093642240dd83424;5dc12c55c5128854093642240dd83424;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;503.3393,-194.348;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1164.055,-88.58872;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Fire;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;36;0;37;0
WireConnection;36;1;29;0
WireConnection;31;0;30;0
WireConnection;31;1;29;0
WireConnection;35;1;36;0
WireConnection;28;0;25;0
WireConnection;28;1;31;0
WireConnection;39;0;35;0
WireConnection;39;1;40;0
WireConnection;39;2;41;0
WireConnection;24;0;28;0
WireConnection;24;1;26;0
WireConnection;32;0;33;0
WireConnection;32;1;24;0
WireConnection;32;2;34;0
WireConnection;42;0;39;0
WireConnection;42;1;43;0
WireConnection;44;0;24;0
WireConnection;44;1;42;0
WireConnection;21;1;32;0
WireConnection;45;0;21;0
WireConnection;45;1;44;0
WireConnection;23;0;22;0
WireConnection;23;1;45;0
WireConnection;0;2;23;0
WireConnection;0;10;23;0
ASEEND*/
//CHKSM=09DB74C36E84B14AF4F4193C832A04D9954CE892