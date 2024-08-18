//
//  MNRInput.swift
//  Miner
//
//  Created by Juan Hurtado on 16/08/24.
//

import CoreGraphics

struct MNRInput {}

// MARK: - Mouse
extension MNRInput {
    /// Current mouse local position
    static var mousePosition: CGPoint = .zero
    
    static func moveMouse(x: CGFloat, y: CGFloat) {
        let point = CGPoint(x: x, y: y)
        let moveEvent = CGEvent(
            mouseEventSource: nil,
            mouseType: .mouseMoved,
            mouseCursorPosition: point,
            mouseButton: .left
        )
        moveEvent?.post(tap: .cgSessionEventTap)
        mousePosition = point
    }
}
