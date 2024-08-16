//
//  MNRNode.swift
//  Miner
//
//  Created by Juan Hurtado on 9/08/24.
//

import MetalKit

class MNRNode {
    var children: [MNRNode] = []
    var components: [MNRComponent] = [
        TransformComponent()
    ]
    
    func draw(using encoder: MTLRenderCommandEncoder, uniforms: Uniforms) {
        for node in children {
            node.draw(using: encoder, uniforms: uniforms)
        }
    }
}
