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
    var lastMousePos: CGPoint = .init(x: 675.171875, y: 314.43359375)
    var mousePosition: CGPoint = .zero
    
    var yaw: Float = 90
    var pitch: Float = 0
    let mouseSensitity: Float = 0.1
    
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
        // update camera with keyboard
        let cameraSpeed: Float = 3 * Float(deltaTime)
        let front = currentCamera.front
        
        if MNRInput.isKeyDown(.w) {
            currentCamera.position += front * cameraSpeed
        }
        if MNRInput.isKeyDown(.s) {
            currentCamera.position -= front * cameraSpeed
        }
        if MNRInput.isKeyDown(.a) {
            currentCamera.position += normalize(cross(front, currentCamera.up)) * cameraSpeed
        }
        if MNRInput.isKeyDown(.d) {
            currentCamera.position -= normalize(cross(front, currentCamera.up)) * cameraSpeed
        }
        
        // update camera with mouse
        let currentPos = MNRInput.mousePosition
        
        var xOffset = Float(lastMousePos.x - currentPos.x)
        var yOffset = Float(lastMousePos.y - currentPos.y)
        
        xOffset *= mouseSensitity
        yOffset *= mouseSensitity
        
        yaw += xOffset
        pitch += yOffset
        
        if pitch > 89 {
            pitch = 89
        }
        
        var direction: float3 = .zero
        direction.x = cosf(yaw.degreesToRadians) * cosf(pitch.degreesToRadians)
        direction.y = -sinf(pitch.degreesToRadians)
        direction.z = sinf(yaw.degreesToRadians) * cosf(pitch.degreesToRadians)
        currentCamera.front = normalize(direction)
        
        lastMousePos = currentPos
        print(currentPos)
    }
}
