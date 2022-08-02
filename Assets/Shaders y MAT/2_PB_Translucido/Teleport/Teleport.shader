// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Teleport"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TeleportSlider("Teleport Slider", Range( -5 , 10)) = 3.451429
		_Albedo("Albedo", 2D) = "white" {}
		_addcoloralbedo("add color albedo", Color) = (1,1,1,0)
		[HDR]_BaseColor("BaseColor", Color) = (0.2604572,1.200997,2.763741,0)
		_offsetFuerza("offset Fuerza", Range( 0 , 0.5)) = 0
		[Toggle]_ToggleSwitch0("Toggle Switch0", Float) = 0
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
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float _TeleportSlider;
		uniform float _ToggleSwitch0;
		uniform float _offsetFuerza;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _addcoloralbedo;
		uniform float4 _BaseColor;
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 transform22 = mul(unity_ObjectToWorld,float4( ase_vertex3Pos , 0.0 ));
			float PosicionY20 = saturate( ( ( transform22.y + _TeleportSlider ) / (( _ToggleSwitch0 )?( -10.0 ):( 10.0 )) ) );
			float mulTime7 = _Time.y * 0.5;
			float2 temp_cast_1 = (0.25).xx;
			float2 panner5 = ( mulTime7 * temp_cast_1 + float2( 0,0 ));
			float2 uv_TexCoord1 = v.texcoord.xy * float2( 5,5 ) + panner5;
			float simplePerlin2D2 = snoise( uv_TexCoord1*9.0 );
			simplePerlin2D2 = simplePerlin2D2*0.5 + 0.5;
			float noise14 = ( simplePerlin2D2 + 0.4 );
			float3 vertexOffset67 = ( ( ( ase_vertex3Pos * PosicionY20 ) * _offsetFuerza ) * noise14 );
			v.vertex.xyz += vertexOffset67;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 albedo51 = ( tex2D( _Albedo, uv_Albedo ) * _addcoloralbedo );
			o.Albedo = albedo51.rgb;
			float mulTime7 = _Time.y * 0.5;
			float2 temp_cast_1 = (0.25).xx;
			float2 panner5 = ( mulTime7 * temp_cast_1 + float2( 0,0 ));
			float2 uv_TexCoord1 = i.uv_texcoord * float2( 5,5 ) + panner5;
			float simplePerlin2D2 = snoise( uv_TexCoord1*9.0 );
			simplePerlin2D2 = simplePerlin2D2*0.5 + 0.5;
			float noise14 = ( simplePerlin2D2 + 0.4 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform22 = mul(unity_ObjectToWorld,float4( ase_vertex3Pos , 0.0 ));
			float PosicionY20 = saturate( ( ( transform22.y + _TeleportSlider ) / (( _ToggleSwitch0 )?( -10.0 ):( 10.0 )) ) );
			float4 emissive43 = ( _BaseColor * ( noise14 * PosicionY20 ) );
			o.Emission = emissive43.rgb;
			o.Alpha = 1;
			float opacity31 = ( ( ( ( 1.0 - PosicionY20 ) * noise14 ) - PosicionY20 ) + ( 1.0 - PosicionY20 ) );
			clip( opacity31 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
1819;-34;1150;685;1086.766;1888.759;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;16;-2618.751,-1590.124;Inherit;False;1887.342;605.3306;Noise;9;8;7;9;4;5;11;13;12;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;27;-2713.909,-835.9895;Inherit;False;1837.528;629.4828;Y poss effect;10;20;26;23;18;77;19;74;22;76;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;17;-2663.908,-715.3855;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-2568.751,-1256.819;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;7;-2396.744,-1174.189;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-2102.321,-439.3053;Inherit;False;Constant;_Negativo;Negativo;8;0;Create;True;0;0;False;0;False;-10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2446.34,-467.9842;Inherit;False;Property;_TeleportSlider;Teleport Slider;1;0;Create;True;0;0;False;0;False;3.451429;5.1;-5;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;22;-2399.593,-785.9893;Inherit;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-2396.746,-1354.627;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;False;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2111.78,-339.3084;Inherit;False;Constant;_positivo;positivo;8;0;Create;True;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;77;-1872.599,-416.333;Inherit;False;Property;_ToggleSwitch0;Toggle Switch0;6;0;Create;True;0;0;False;0;False;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;4;-2174.15,-1499.652;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;False;5,5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;5;-2158.972,-1295.605;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-2064.264,-721.5513;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;23;-1670.925,-686.538;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1912.931,-1506.19;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-1712.894,-1155.427;Inherit;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;False;9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1416.254,-1242.793;Inherit;True;Constant;_Float3;Float 3;1;0;Create;True;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;26;-1401.258,-705.663;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;2;-1521.298,-1540.124;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;39;-2819.925,-76.98175;Inherit;False;1856.361;646.5166;opacity;9;36;34;38;37;31;30;28;21;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-1206.797,-679.7017;Inherit;True;PosicionY;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1213.253,-1315.793;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;73;-3826.211,747.1716;Inherit;False;1495.274;835.1412;vertex offset;8;72;71;67;69;70;66;65;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-952.7663,-1530.543;Inherit;False;noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-2769.925,-26.98173;Inherit;True;20;PosicionY;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;-2458.681,290.8432;Inherit;True;14;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;-2433.11,-25.77832;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;-3729.898,1073.331;Inherit;False;20;PosicionY;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;64;-3776.211,797.1716;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;47;-529.0549,-1559.517;Inherit;False;1064.841;726.0773;Emissive;6;41;42;40;45;43;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2146.628,-7.410215;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-473.3899,-1302.752;Inherit;True;14;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;41;-464.1938,-1063.44;Inherit;True;20;PosicionY;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-3658.586,1325.683;Inherit;False;Property;_offsetFuerza;offset Fuerza;5;0;Create;True;0;0;False;0;False;0;0.265;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-2171.44,338.6524;Inherit;True;20;PosicionY;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;-2125.517,708.9205;Inherit;False;1191.85;585.1925;textura base;4;51;50;49;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-3484.164,935.1108;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;46;-482.1873,-1509.517;Inherit;False;Property;_BaseColor;BaseColor;4;1;[HDR];Create;False;0;0;False;0;False;0.2604572,1.200997,2.763741,0;0.2604572,1.200997,2.763741,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;49;-1981.917,1109.707;Inherit;False;Property;_addcoloralbedo;add color albedo;3;0;Create;True;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;-2054.346,758.9205;Inherit;True;Property;_Albedo;Albedo;2;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;38;-1745.825,316.5349;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-220.2523,-1156.871;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-3205.736,1352.313;Inherit;True;14;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;36;-1769.976,39.49072;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-3186.292,976.206;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;23.10744,-1388.062;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-1537.508,218.6637;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1597.135,1010.753;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-2862.955,949.1163;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;292.7859,-1376.392;Inherit;True;emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-1191.993,1003.259;Inherit;True;albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-2573.936,933.3589;Inherit;True;vertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;91;-2658.012,-2119.447;Inherit;False;1670.146;469.2574;efecto 2 --- mal;9;80;84;82;89;85;83;87;81;79;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-1206.562,231.2953;Inherit;True;opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;1170.761,241.4659;Inherit;True;67;vertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;-1881.501,-2062.527;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;44;495.0976,-480.5406;Inherit;True;43;emissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2608.012,-1846.906;Inherit;False;Property;_speedlinnes;speed linnes;9;0;Create;True;0;0;False;0;False;0;0.74;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-1503.49,-1794.968;Inherit;False;Property;_thickness;thickness;7;0;Create;True;0;0;False;0;False;0;0.44;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-2523.69,-1993.587;Inherit;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;False;0;False;4.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;82;-1222.866,-2027.929;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;80;-1581.649,-2027.929;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;85;-2419.304,-1760.189;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;1043.805,-710.2685;Inherit;True;51;albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;603.4177,263.1483;Inherit;True;31;opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2093.703,-2069.447;Inherit;False;Property;_noisescale;noise scale;8;0;Create;True;0;0;False;0;False;0;6.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;84;-2105.918,-1853.35;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1377.894,-300.3457;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Teleport;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;8;0
WireConnection;22;0;17;0
WireConnection;77;0;76;0
WireConnection;77;1;74;0
WireConnection;5;2;9;0
WireConnection;5;1;7;0
WireConnection;18;0;22;2
WireConnection;18;1;19;0
WireConnection;23;0;18;0
WireConnection;23;1;77;0
WireConnection;1;0;4;0
WireConnection;1;1;5;0
WireConnection;26;0;23;0
WireConnection;2;0;1;0
WireConnection;2;1;11;0
WireConnection;20;0;26;0
WireConnection;12;0;2;0
WireConnection;12;1;13;0
WireConnection;14;0;12;0
WireConnection;28;0;21;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;66;0;64;0
WireConnection;66;1;65;0
WireConnection;38;0;34;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;36;0;30;0
WireConnection;36;1;34;0
WireConnection;69;0;66;0
WireConnection;69;1;70;0
WireConnection;45;0;46;0
WireConnection;45;1;42;0
WireConnection;37;0;36;0
WireConnection;37;1;38;0
WireConnection;50;0;48;0
WireConnection;50;1;49;0
WireConnection;72;0;69;0
WireConnection;72;1;71;0
WireConnection;43;0;45;0
WireConnection;51;0;50;0
WireConnection;67;0;72;0
WireConnection;31;0;37;0
WireConnection;79;0;81;0
WireConnection;79;1;84;0
WireConnection;82;0;80;0
WireConnection;82;1;83;0
WireConnection;80;0;79;2
WireConnection;85;0;87;0
WireConnection;84;2;89;0
WireConnection;84;1;85;0
WireConnection;0;0;52;0
WireConnection;0;2;44;0
WireConnection;0;10;32;0
WireConnection;0;11;68;0
ASEEND*/
//CHKSM=A882B9793E421DCC9DF9034A5010E6A090856084