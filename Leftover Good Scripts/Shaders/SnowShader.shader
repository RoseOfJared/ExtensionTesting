// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/SnowShader" {
	Properties {
		_MainColor ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Bump ("Bump", 2D) = "bump"{}
		_Snow("Level of Snow", Range(1, -1)) = 1
		_SnowColor("Color of Snow", Color) = (1,1,1,1)
		_SnowDirection("Direction of Snow", Vector) = (0,1,0)
		_SnowDepth("Depth of Snow", Range(0, 0.0001)) = 0
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Lambert vertex:vert

			sampler2D _MainTex;
			sampler2D _Bump;
			float _Snow;
			float4 _SnowColor;
			float4 _MainColor;
			float4 _SnowDirection;
			float _SnowDepth;

			struct Input {
				float2 uv_MainTex;
				float2 uv_Bump;
				float3 worldNormal;
				INTERNAL_DATA
			};

			void vert(inout appdata_full v) {
				//Convert the normal to world coordinates
				float4 sn = mul(_SnowDirection, unity_WorldToObject);
				if (dot(v.normal, sn.xyz) >= _Snow)
					v.vertex.xyz += (sn.xyz + v.normal) * _SnowDepth * _Snow;
			}
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));

			if (dot(WorldNormalVector(IN, o.Normal), _SnowDirection.xyz) >= _Snow)
				o.Albedo = _SnowColor.rgb;
			else
				o.Albedo = c.rgb * _MainColor;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
