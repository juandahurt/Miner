//
//  MNRVoxel.swift
//  Miner
//
//  Created by Juan Hurtado on 23/06/24.
//

import MetalKit

class MNRVoxel {
    var type: MNRVoxelType = .earth
    
    var position: SIMD3<Float> = .zero
    var vertexBuffer: MTLBuffer
    var indexBuffer: MTLBuffer
    
    var vertices: [MNRVertex] = [
        // front
        .init(position: [0.5, -0.5, -0.5], textureCoordinates: [4.0 / 16.0, 1.0 / 16.0]),
        .init(position: [-0.5, -0.5, -0.5], textureCoordinates: [3 / 16, 1 / 16]),
        .init(position: [0.5, 0.5, -0.5], textureCoordinates: [4 / 16, 0]),
        .init(position: [ -0.5, 0.5, -0.5], textureCoordinates: [3 / 16, 0]),
        
        // back
        .init(position: [0.5, -0.5, 0.5], textureCoordinates: [4.0 / 16.0, 1.0 / 16.0]),
        .init(position: [-0.5, -0.5, 0.5], textureCoordinates: [3 / 16, 1 / 16]),
        .init(position: [0.5, 0.5, 0.5], textureCoordinates: [4 / 16, 0]),
        .init(position: [ -0.5, 0.5, 0.5], textureCoordinates: [3 / 16, 0]),
        
        // top
        .init(position: [0.5, 0.5, -0.5], textureCoordinates: [1.0 / 16.0, 1.0 / 16.0]),
        .init(position: [-0.5, 0.5, -0.5], textureCoordinates: [0, 1 / 16]),
        .init(position: [0.5, 0.5, 0.5], textureCoordinates: [1 / 16, 0]),
        .init(position: [ -0.5, 0.5, 0.5], textureCoordinates: [0, 0]),
        
        // bottom
        .init(position: [0.5, -0.5, -0.5], textureCoordinates: [3.0 / 16.0, 1.0 / 16.0]),
        .init(position: [-0.5, -0.5, -0.5], textureCoordinates: [2 / 16, 1 / 16]),
        .init(position: [0.5, -0.5, 0.5], textureCoordinates: [3 / 16, 0]),
        .init(position: [ -0.5, -0.5, 0.5], textureCoordinates: [2 / 16, 0]),
        
        // left
        .init(position: [-0.5, -0.5, -0.5], textureCoordinates: [4.0 / 16.0, 1.0 / 16.0]),
        .init(position: [-0.5, -0.5, 0.5], textureCoordinates: [3 / 16, 1 / 16]),
        .init(position: [-0.5, 0.5, -0.5], textureCoordinates: [4 / 16, 0]),
        .init(position: [-0.5, 0.5, 0.5], textureCoordinates: [3 / 16, 0]),
        
        // right
        .init(position: [0.5, -0.5, -0.5], textureCoordinates: [4.0 / 16.0, 1.0 / 16.0]),
        .init(position: [0.5, -0.5, 0.5], textureCoordinates: [3 / 16, 1 / 16]),
        .init(position: [0.5, 0.5, -0.5], textureCoordinates: [4 / 16, 0]),
        .init(position: [0.5, 0.5, 0.5], textureCoordinates: [3 / 16, 0]),
    ]
    
    var indices: [UInt16] = [
        // back face
        0, 1, 2,
        1, 2, 3,
        
        // front face
        4, 5, 6,
        5, 6, 7,
        
        // top face
        8, 9, 10,
        9, 10, 11,
        
        // bottom face
        12, 13, 14,
        13, 14, 15,
        
        // left face
        16, 17, 18,
        17, 18, 19,
        
        // left face
        20, 21, 22,
        21, 22, 23
    ]
    
    private func loadTextureCoordinates() {
//        for var vertex in vertices {
//            vertex.
//        }
    }
    
    init(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<MNRVertex>.stride * vertices.count
        )!
        indexBuffer = device.makeBuffer(
            bytes: &indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        )!
    }
    
    func draw(using encoder: MTLRenderCommandEncoder) {
        encoder.setVertexBuffer(
            vertexBuffer,
            offset: 0,
            index: 0
        )
        encoder.drawIndexedPrimitives(
            type: .triangle,
            indexCount: indices.count,
            indexType: .uint16,
            indexBuffer: indexBuffer,
            indexBufferOffset: 0
        )
    }
}
