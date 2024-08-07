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
    let voxel: MNRVoxel
    
    var depthStencilState: MTLDepthStencilState?
    
    var uniforms = Uniforms()
    var value: Float = 0.0
    
    let texture: MTLTexture!
    
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
        
        voxel = .init(device: device)
        
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
        value += 0.01
        
        uniforms.viewMatrix = float4x4(translation: [0, 0, 5])
//        uniforms.modelMatrix = .init(translation: [Float(sin(value)), 0, 0])
        uniforms.modelMatrix = float4x4(rotation: [Float(sin(value)), Float(sin(value)), 0])
        
        encoder.setDepthStencilState(depthStencilState)
        encoder.setFragmentTexture(texture, index: 0)
        encoder.setVertexBytes(
            &uniforms,
            length: MemoryLayout<Uniforms>.stride,
            index: 10
        )
        encoder.setRenderPipelineState(renderPipelineState!)
        voxel.draw(using: encoder)
        
        encoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
