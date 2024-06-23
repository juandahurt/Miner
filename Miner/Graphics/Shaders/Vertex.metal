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
    float3 color [[attribute(1)]];
};

struct RasterizerData {
    float4 position [[position]];
    float4 color;
};

RasterizerData vertex vertexShader(const Vertex inVertex [[stage_in]]) {
    return {
        .position = float4(inVertex.position, 1),
        .color = float4(inVertex.color, 1)
    };
}
