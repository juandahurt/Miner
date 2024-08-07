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
        self.renderer = MNRRenderer(device: MNRGraphics.device)
        super.init(frame: frame, device: MNRGraphics.device)
        delegate = renderer
        
        clearColor = .init(red: 0.1, green: 0.1, blue: 0.5, alpha: 1)
        depthStencilPixelFormat = .depth16Unorm
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
