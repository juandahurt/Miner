//
//  MNRMainScene.swift
//  Miner
//
//  Created by Juan Hurtado on 9/08/24.
//

class MNRMainScene: MNRScene {
    var voxels: [MNRVoxel] = []
    let numOfVoxels = 4
    var value = 0.0
    var mousePosition: CGPoint = .zero
    
    override func setup() {
        for _ in 0..<numOfVoxels {
            let voxel = MNRVoxel()
            addNode(node: voxel)
            voxels.append(voxel)
        }
        
        voxels[0].getComponent(TransformComponent.self).position = [5, 0, 0]
        voxels[1].getComponent(TransformComponent.self).position = [0, -3, 0]
        voxels[2].getComponent(TransformComponent.self).position = [-1, 0, 4]
    }
    
    override func update() {
        if mousePosition != MNRInput.mousePosition {
            mousePosition = MNRInput.mousePosition
        }
        if MNRInput.isKeyDown(.w) {
            print(mousePosition)
            print("w is being pressed")
        }
        value += 0.1
        voxels[0].getComponent(TransformComponent.self).rotation.x = sin(Float(value))
    }
}
