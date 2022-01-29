// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

Shader "SmewBrush/Fire" {
Properties {
  _MainTex ("Particle Texture", 2D) = "white" {}
  _Scroll1("Scroll1", Float) = 0
  _Scroll2("Scroll2", Float) = 0
  _DisplacementIntensity("Displacement", Float) = .1
	_EmissionGain("Emission Gain", Range(0, 1)) = 0.5
}

Category{
  Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
  Blend One One // SrcAlpha One
  BlendOp Add, Min
  ColorMask RGBA
  Cull Off Lighting Off ZWrite Off //Fog { Color (0,0,0,0) }

  SubShader {
	Pass {

	  CGPROGRAM
	  #pragma vertex vert
	  #pragma fragment frag
	  #pragma target 3.0
	  #pragma multi_compile_particles
	  #pragma multi_compile __ TBT_LINEAR_TARGET

	  #include "UnityCG.cginc"

	  sampler2D_half _MainTex;

      struct appdata_t {
        half4 vertex : POSITION;
        fixed4 color : COLOR;
        half3 normal : NORMAL;
#if SHADER_TARGET >= 40
        centroid half2 texcoord : TEXCOORD0;
#else
        half2 texcoord : TEXCOORD0;
#endif
        half3 worldPos : TEXCOORD1;
      };

      struct v2f {
        half4 vertex : POSITION;
        fixed4 color : COLOR;
#if SHADER_TARGET >= 40
        centroid half2 texcoord : TEXCOORD0;
#else
        half2 texcoord : TEXCOORD0;
#endif
        half3 worldPos : TEXCOORD1;
      };

      half4 _MainTex_ST;
      fixed _Scroll1;
      fixed _Scroll2;
      half _DisplacementIntensity;
      half _EmissionGain;

	  //from brush.cginc
	  fixed4 LinearToSrgb(fixed4 color) {

		  fixed3 linearColor = color.rgb;
		  fixed3 S1 = sqrt(linearColor);
		  fixed3 S2 = sqrt(S1);
		  fixed3 S3 = sqrt(S2);
		  color.rgb = 0.662002687 * S1 + 0.684122060 * S2 - 0.323583601 * S3 - 0.0225411470 * linearColor;
		  return color;
	  }

	  fixed4 bloomColor(fixed4 color, fixed gain) {
		  // Guarantee that there's at least a little bit of all 3 channels.
		  // This makes fully-saturated strokes (which only have 2 non-zero
		  // color channels) eventually clip to white rather than to a secondary.
		  fixed cmin = length(color.rgb) * .05;
		  color.rgb = max(color.rgb, fixed3(cmin, cmin, cmin));
		  // If we try to remove this pow() from .a, it brightens up
		  // pressure-sensitive strokes; looks better as-is.
		  color = pow(color, 2.2);
		  color.rgb *= 2 * exp(gain * 10);
		  return color;
	  }

	  fixed4 TbVertToSrgb(fixed4 color) { return LinearToSrgb(color); }
	  fixed4 SrgbToNative(fixed4 color) { return color; }

	  v2f vert (appdata_t v)
      {
        v.color = TbVertToSrgb(v.color);
        v2f o;
        o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
        o.color = bloomColor(v.color, _EmissionGain);
        o.vertex = UnityObjectToClipPos(v.vertex);
        o.worldPos = mul(unity_ObjectToWorld, v.vertex);
        return o;
      }

      // Note: input color is srgb
      fixed4 frag (v2f i) : COLOR
      {
        half2 displacement;
        half procedural_line = 0;

		displacement = tex2D(_MainTex, i.texcoord + half2(-_Time.x / 5 * _Scroll1, 0)).a;
        half4 tex = tex2D(_MainTex, i.texcoord + half2(-_Time.x/5 * _Scroll2, 0) - displacement * _DisplacementIntensity);

        fixed4 color = i.color * tex;
        color = fixed4(color.rgb * color.a, 1.0);
        color = SrgbToNative(color);
        return color;
      }
      ENDCG
    }
  }
}
}
