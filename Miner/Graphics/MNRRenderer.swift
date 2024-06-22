//
//  MNRRenderer.swift
//  Miner
//
//  Created by Juan Hurtado on 10/06/24.
//

import MetalKit

class MNRRenderer: NSObject, MTKViewDelegate {
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    
    let vertices: [Float] = [
        0, 1, 0,
        -1, -1, 0,
        1, -1, 0
    ]
    let indices: [Int16] = [
        0, 1, 2
    ]
    let vertexBuffer: MTLBuffer!
    let indexBuffer: MTLBuffer!
    let renderPipelineState: MTLRenderPipelineState?
    
    init(device: MTLDevice) {
        self.device = device
        guard let commandQueue = device.makeCommandQueue() else {
            MNRLogger.error(message: "command queue could not be created")
            fatalError()
        }
        self.commandQueue = commandQueue
        
        vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Float>.stride * vertices.count
        )
        indexBuffer = device.makeBuffer(
            bytes: &indices,
            length: MemoryLayout<Int16>.stride * indices.count
        )
        
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
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        renderPipelineState = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        MNRLogger.debug(message: "view is being resized")
    }
    
    func draw(in view: MTKView) {
        guard 
            let drawable = view.currentDrawable,
            let renderDescriptor = view.currentRenderPassDescriptor,
            let commandBuffer = commandQueue.makeCommandBuffer()
        else {
            return
        }
        let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor)
        
        encoder?.setRenderPipelineState(renderPipelineState!)
        encoder?.setVertexBuffer(
            vertexBuffer,
            offset: 0,
            index: 0
        )
        encoder?.drawIndexedPrimitives(
            type: .triangle,
            indexCount: indices.count,
            indexType: .uint16,
            indexBuffer: indexBuffer,
            indexBufferOffset: 0
        )
        
        encoder?.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
