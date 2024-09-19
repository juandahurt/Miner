//
//  MNRRenderer.swift
//  Miner
//
//  Created by Juan Hurtado on 10/06/24.
//

import MetalKit

class MNRRenderer: NSObject, MTKViewDelegate {
    let commandQueue: MTLCommandQueue
    let renderPipelineState: MTLRenderPipelineState?
    
    var depthStencilState: MTLDepthStencilState?
    
    var uniforms = Uniforms()
    
    let texture: MTLTexture!
    
    var cameraPos = float3([0, 0, -3])
    var deltaTime: Double = 0
    var lasTime: Double = 0
    
    init(device: MTLDevice) {
        guard let commandQueue = device.makeCommandQueue() else {
            MNRLogger.error(message: "command queue could not be created")
            fatalError()
        }
        self.commandQueue = commandQueue
        
        guard let library = device.makeDefaultLibrary() else {
            MNRLogger.error(message: "metal files couldn't be found")
            fatalError()
        }
        let vertexFunction = library.makeFunction(name: "vertexShader")
        let fragmentFunction = library.makeFunction(name: "fragmentShader")
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        vertexDescriptor.attributes[1].format = .float2
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        vertexDescriptor.attributes[1].bufferIndex = 0
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<MNRVertex>.stride
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.depthAttachmentPixelFormat = .depth16Unorm
        
        renderPipelineState = try? device.makeRenderPipelineState(
            descriptor: pipelineDescriptor
        )
        
        let textureLoader = MTKTextureLoader(device: device)
        let url = Bundle.main.url(forResource: "textures", withExtension: "png")!
        texture = try! textureLoader.newTexture(URL: url)
        
        let stencilDescriptor = MTLDepthStencilDescriptor()
        stencilDescriptor.depthCompareFunction = .less
        stencilDescriptor.isDepthWriteEnabled = true
        depthStencilState = device.makeDepthStencilState(descriptor: stencilDescriptor)
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        MNRLogger.debug(message: "view is being resized")
        let projectionMatrix = float4x4(
            projectionFov: Float(45).degreesToRadians,
            near: 0.1,
            far: 100,
            aspect: Float(size.width) / Float(size.height)
        )
        uniforms.projectionMatrix = projectionMatrix
        
        MNRWindow.updateSize(size)
    }
    
    func draw(in view: MTKView) {
        guard 
            let drawable = view.currentDrawable,
            let renderDescriptor = view.currentRenderPassDescriptor,
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor)
        else {
            return
        }
        let currentTime = Date().timeIntervalSince1970
        deltaTime = currentTime - lasTime
        lasTime = currentTime
        
        let cameraFront = float3([0, 0, 1])
        let cameraUp = float3([0, 1, 0])
        let viewMatrix = float4x4(eye: cameraPos, center: cameraPos + cameraFront, up: cameraUp)
        let cameraSpeed: Float = 0.1
        
        if MNRInput.isKeyDown(.w) {
            cameraPos += cameraFront * cameraSpeed
        }
        if MNRInput.isKeyDown(.s) {
            cameraPos -= cameraFront * cameraSpeed
        }
        if MNRInput.isKeyDown(.a) {
            cameraPos += normalize(cross(cameraFront, cameraUp)) * cameraSpeed
        }
        if MNRInput.isKeyDown(.d) {
            cameraPos -= normalize(cross(cameraFront, cameraUp)) * cameraSpeed
        }
        
        uniforms.viewMatrix = viewMatrix
        
        encoder.setDepthStencilState(depthStencilState)
        encoder.setFragmentTexture(texture, index: 0)
        encoder.setRenderPipelineState(renderPipelineState!)
        
        // update and draw scene
        let currentScene = MNRSceneManager.instance.currentScene
        currentScene?.update(deltaTime: Float(deltaTime))
        currentScene?.draw(using: encoder, uniforms: uniforms)
        
        encoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
