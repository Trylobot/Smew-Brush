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

Shader "Brush/Special/Fire" {
Properties {
  _MainTex ("Particle Texture", 2D) = "white" {}
  _Scroll1 ("Scroll1", Float) = 0
  _Scroll2 ("Scroll2", Float) = 0
  _DisplacementIntensity("Displacement", Float) = .1
    _EmissionGain ("Emission Gain", Range(0, 1)) = 0.5
}

Category {
  Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
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
      #include "../../../Shaders/Include/Brush.cginc"

      sampler2D _MainTex;

      struct appdata_t {
        float4 vertex : POSITION;
        fixed4 color : COLOR;
        float3 normal : NORMAL;
#if SHADER_TARGET >= 40
        centroid float2 texcoord : TEXCOORD0;
#else
        float2 texcoord : TEXCOORD0;
#endif
        float3 worldPos : TEXCOORD1;
      };

      struct v2f {
        float4 vertex : POSITION;
        float4 color : COLOR;
#if SHADER_TARGET >= 40
        centroid float2 texcoord : TEXCOORD0;
#else
        float2 texcoord : TEXCOORD0;
#endif
        float3 worldPos : TEXCOORD1;
      };

      float4 _MainTex_ST;
      fixed _Scroll1;
      fixed _Scroll2;
      half _DisplacementIntensity;
      half _EmissionGain;

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
        float procedural_line = 0;

		displacement = tex2D(_MainTex, i.texcoord + half2(-_Time.x / 5 * _Scroll1, 0)).a;
        half4 tex = tex2D(_MainTex, i.texcoord + half2(-_Time.x/5 * _Scroll2, 0) - displacement * _DisplacementIntensity);

        float4 color = i.color * tex;
        color = float4(color.rgb * color.a, 1.0);
        color = SrgbToNative(color);
        return color;
      }
      ENDCG
    }
  }
}
}
