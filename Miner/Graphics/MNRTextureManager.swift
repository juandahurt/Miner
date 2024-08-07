//
//  MNRTextureManager.swift
//  Miner
//
//  Created by Juan Hurtado on 7/07/24.
//

import MetalKit

enum MNRVoxelType {
    case earth
}

enum MNRVoxelFace {
    case top, bottom, side
}

struct TexturePositionId: Hashable {
    let type: MNRVoxelType
    let face: MNRVoxelFace
}

class MNRTextureManager {
    private var texturePositions: [TexturePositionId: (UInt, UInt)] = [:]
    
    private let texture: MTLTexture
    
    private init() {
        let textureLoader = MTKTextureLoader(device: MNRGraphics.device)
        let url = Bundle.main.url(forResource: "textures", withExtension: "png")!
        texture = try! textureLoader.newTexture(URL: url)
    }
    
    private func loadTexturePositions() {
        texturePositions = [
            .init(type: .earth, face: .top): (0, 0)
        ]
    }
    
//    func getTexturePosition(ofType: MNRVoxelType, face: MNRVoxelFace) -> SIMD2<UInt> {
//        let positions = texturePositions[TexturePositionId(type: type, face: face)]
//        return [positions.0, positions.1]
//    }
}


// MARK: - Singleton
extension MNRTextureManager {
    static var instance: MNRTextureManager {
        get {
            _instance!
        }
    }
    static var _instance: MNRTextureManager?
    
    static func load() {
        _instance = .init()
    }
}
