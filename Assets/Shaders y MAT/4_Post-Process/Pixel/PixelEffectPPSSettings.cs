// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( PixelEffectPPSRenderer ), PostProcessEvent.AfterStack, "PixelEffect", true )]
public sealed class PixelEffectPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Pixels x" )]
	public FloatParameter _Pixelsx = new FloatParameter { value = 1000f };
	[Tooltip( "Pixels Y" )]
	public FloatParameter _PixelsY = new FloatParameter { value = 1000f };
}

public sealed class PixelEffectPPSRenderer : PostProcessEffectRenderer<PixelEffectPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "PixelEffect" ) );
		sheet.properties.SetFloat( "_Pixelsx", settings._Pixelsx );
		sheet.properties.SetFloat( "_PixelsY", settings._PixelsY );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
