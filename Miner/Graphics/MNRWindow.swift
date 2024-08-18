//
//  MNRWindow.swift
//  Miner
//
//  Created by Juan Hurtado on 16/08/24.
//

import Foundation

struct MNRWindow {
    private(set) static var size: CGSize = .zero // TODO: set initial size
    
    static func updateSize(_ newSize: CGSize) {
        self.size = newSize
    }
}
