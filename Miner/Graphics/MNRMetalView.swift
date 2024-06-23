//
//  MNRMetalView.swift
//  Miner
//
//  Created by Juan Hurtado on 10/06/24.
//

import MetalKit

class MNRMetalView: MTKView {
    private var renderer: MNRRenderer
    
    init(frame: CGRect) {
        guard let device = MTLCreateSystemDefaultDevice() else {
            MNRLogger.error(message: "GPU is not available")
            fatalError()
        }
        self.renderer = MNRRenderer(device: device)
        super.init(frame: frame, device: device)
        delegate = renderer
        
        clearColor = .init(red: 0.1, green: 0.1, blue: 0.5, alpha: 1)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
