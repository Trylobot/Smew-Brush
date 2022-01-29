Shader "SmewBrush/HyperColorUnlit"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "IgnoreProjector" = "True" "Queue" = "Transparent"}
        LOD 100
        Cull Off
        ZWrite on
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				
                half4 tex = tex2D(_MainTex, i.uv);

                float scroll = _Time.z;

                tex.r = (sin(tex.r * 2 + scroll*0.5 - i.uv.x) + 1);
                tex.g = (sin(tex.r * 3.3 + scroll*0.5 - i.uv.x) + 1);
                tex.b = (sin(tex.r * 4.66 + scroll*0.25 - i.uv.x) + 1);

                return tex;
            }
            ENDCG
        }
    }
}
