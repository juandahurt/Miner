//
//  MNRMainScene.swift
//  Miner
//
//  Created by Juan Hurtado on 9/08/24.
//

class MNRMainScene: MNRScene {
    var voxels: [MNRVoxel] = []
    let numOfVoxels = 20
    let numRows = 20
    let numCols = 20
    var mousePosition: CGPoint = .zero
    
    override func setup() {
        for row in 0..<numRows {
            for col in 0..<numCols {
                let voxel = MNRVoxel()
                addNode(node: voxel)
                voxels.append(voxel)
                voxel.getComponent(TransformComponent.self).position = [Float(col), -2, Float(row)]
            }
        }
    }
    
    override func update(deltaTime: Float) {
        
    }
}
