//
//  ViewController.swift
//  Miner
//
//  Created by Juan Hurtado on 29/05/24.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MNRLogger.setup()
        
        
        let metalView = MNRMetalView(frame: view.bounds)
        metalView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(metalView)
        
        NSLayoutConstraint.activate([
            metalView.topAnchor.constraint(equalTo: view.topAnchor),
            metalView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            metalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            metalView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

