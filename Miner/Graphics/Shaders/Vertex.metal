//
//  Vertex.metal
//  Miner
//
//  Created by Juan Hurtado on 15/06/24.
//

#include <metal_stdlib>
#include "../Commons.h"

using namespace metal;

struct Vertex {
    float3 position [[attribute(0)]];
    float2 textureCoordinate [[attribute(1)]];
};

struct RasterizerData {
    float4 position [[position]];
    float2 textureCoordiante;
};

RasterizerData vertex vertexShader(const Vertex inVertex [[stage_in]], constant Uniforms& uniforms [[ buffer(10) ]]) {
    return {
        .position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * float4(inVertex.position, 1),
        .textureCoordiante = inVertex.textureCoordinate
    };
}
