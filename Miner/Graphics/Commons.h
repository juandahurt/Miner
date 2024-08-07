//
//  Commons.h
//  Miner
//
//  Created by Juan Hurtado on 28/06/24.
//

#ifndef Commons_h
#define Commons_h

#include <simd/simd.h>

typedef struct {
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectionMatrix;
} Uniforms;

struct MNRVertex {
    simd_float3 position;
    simd_float2 textureCoordinates;
};

#endif /* Commons_h */
