//
//  MNRCamera.swift
//  Miner
//
//  Created by Juan Hurtado on 19/09/24.
//

import Foundation

class MNRCamera {
    var position: float3 = .zero
    var front: float3 = [0, 0, 1]
    var up: float3 = [0, 1, 0]
    
    var matrix: float4x4 {
        float4x4(eye: position, center: position + front, up: up)
    }
}
