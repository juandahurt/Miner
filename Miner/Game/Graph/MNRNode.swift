//
//  MNRNode.swift
//  Miner
//
//  Created by Juan Hurtado on 9/08/24.
//

import MetalKit

class MNRNode {
    var children: [MNRNode] = []
    var position = float3.zero
    var rotation = float3.zero
    
    func draw(using encoder: MTLRenderCommandEncoder, uniforms: Uniforms) {
        for node in children {
            node.draw(using: encoder, uniforms: uniforms)
        }
    }
}
