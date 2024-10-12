//
//  MNRMetalView.swift
//  Miner
//
//  Created by Juan Hurtado on 10/06/24.
//

import MetalKit

class MNRMetalView: MTKView {
    private var renderer: MNRRenderer
    
    /// To observe the mouse position
    private var trackingArea: NSTrackingArea?
    
    override var canBecomeKeyView: Bool { true }
    override var acceptsFirstResponder: Bool { true }
    
    init(frame: CGRect) {
        self.renderer = MNRRenderer(device: MNRGraphics.device)
        super.init(frame: frame, device: MNRGraphics.device)
        delegate = renderer
        
        clearColor = .init(red: 0.83, green: 0.87, blue: 0.98, alpha: 1)
        depthStencilPixelFormat = .depth16Unorm
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let trackingArea {
            removeTrackingArea(trackingArea)
        }
        self.trackingArea = NSTrackingArea(
            rect: bounds,
            options: [.mouseMoved, .activeInActiveApp],
            owner: self
        )
        addTrackingArea(trackingArea!)
    }
}

// MARK: - Input
extension MNRMetalView {
    override func mouseMoved(with event: NSEvent) {
        let location = event.locationInWindow
        MNRInput.mousePosition = .init(x: location.x, y: location.y)
    }
    
    override func keyDown(with event: NSEvent) {
        MNRInput.pressedKey(event)
    }
    
    override func keyUp(with event: NSEvent) {
        MNRInput.releasedKey(event)
    }
}
