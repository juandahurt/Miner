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
    float4 color;
};

float4 fragment fragmentShader(RasterizerData data [[stage_in]]) {
    return data.color;
}
