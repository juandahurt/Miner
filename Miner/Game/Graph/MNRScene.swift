//
//  MNRScene.swift
//  Miner
//
//  Created by Juan Hurtado on 9/08/24.
//

import Foundation

class MNRScene: MNRNode {
    override init() {
        super.init()
        setup()
    }
    
    func addNode(node: MNRNode) {
        children.append(node)
    }
    
    func setup() {}
    func update() {}
}


class MNRSceneManager {
    static var instance = MNRSceneManager()
    
    private(set) var currentScene: MNRScene?
    
    func setCurrentScene(_ scene: MNRScene) {
        currentScene = scene
    }
}
