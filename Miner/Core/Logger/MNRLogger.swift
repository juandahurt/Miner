//
//  MNRLogger.swift
//  Miner
//
//  Created by Juan Hurtado on 10/06/24.
//

import Foundation
import Pepe

struct MNRLogger {
    private static var pepeLogger = Pepe.loggerPlease()
    
    private init() {}
    
    private static func log(message: String, level: LogLevel) {
        pepeLogger.log("MNR: " + message, level: level)
    }
    
    static func setup() {
        pepeLogger.writer = .os(subsystem: "", category: "")
        pepeLogger.modifiers = []
    }
    
    static func info(message: String) {
        log(message: message, level: .info)
    }
    
    static func debug(message: String) {
        log(message: message, level: .debug)
    }
    
    static func warning(message: String) {
        log(message: message, level: .warning)
    }
    
    static func error(message: String) {
        log(message: message, level: .error)
    }
}
