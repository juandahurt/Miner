//
//  MNRGraphics.swift
//  Miner
//
//  Created by Juan Hurtado on 13/07/24.
//

import MetalKit

struct MNRGraphics {
    static var device: MTLDevice {
        get {
            guard let device = MTLCreateSystemDefaultDevice() else {
                fatalError()
            }
            return device
        }
    }
    
    private init() {}
}
