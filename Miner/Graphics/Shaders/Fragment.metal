//
//  Fragment.metal
//  Miner
//
//  Created by Juan Hurtado on 15/06/24.
//

#include <metal_stdlib>
using namespace metal;

struct RasterizerData {
    float4 position [[position]];
    float2 textureCoordiante;
};

float4 fragment fragmentShader(RasterizerData data [[stage_in]], 
                               texture2d<float> colorTexture [[texture(0)]]) {
    constexpr sampler textureSampler(mag_filter::nearest, min_filter::linear);
    auto color = colorTexture.sample(textureSampler, data.textureCoordiante);
    return color;
}
