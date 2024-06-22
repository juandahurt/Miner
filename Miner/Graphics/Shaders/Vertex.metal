//
//  Vertex.metal
//  Miner
//
//  Created by Juan Hurtado on 15/06/24.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float3 position [[attribute(0)]];
};

struct RasterizerData {
    float4 position [[position]];
};

RasterizerData vertex vertexShader(const Vertex inVertex [[stage_in]]) {
    return {
        .position = float4(inVertex.position, 1)
    };
}
