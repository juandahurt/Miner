//
//  MNRInput.swift
//  Miner
//
//  Created by Juan Hurtado on 16/08/24.
//

import CoreGraphics
import Cocoa

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


// MARK: - Keyboard
extension MNRInput {
    static var pressedKeys: [UInt16] = []
    
    static func pressedKey(_ event: NSEvent) {
        assert(event.type == .keyDown)
        guard !pressedKeys.contains(where: { $0 == event.keyCode }) else { return }
        pressedKeys.append(event.keyCode)
    }
    
    static func releasedKey(_ event: NSEvent) {
        assert(event.type == .keyUp)
        assert(pressedKeys.contains(where: { $0 == event.keyCode }))
        pressedKeys.removeAll(where: { $0 == event.keyCode })
    }
    
    static func isKeyDown(_ key: MNRKey) -> Bool {
        pressedKeys.contains(where: { $0 == key.rawValue })
    }
}
