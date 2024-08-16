//
//  MNRNode+getComponent.swift
//  Miner
//
//  Created by Juan Hurtado on 10/08/24.
//

import Foundation

extension MNRNode {
    func getComponent<C>(_ type: C.Type) -> C {
        for c in components {
            if c is C { return c as! C }
        }
        MNRLogger.error(message: "unreachable code! trying to get non existant component")
        fatalError()
    }
}
