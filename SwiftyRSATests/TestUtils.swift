//
//  TestUtils.swift
//  SwiftyRSA
//
//  Created by Loïs Di Qual on 4/1/16.
//  Copyright © 2016 Scoop. All rights reserved.
//

import Foundation
import SwiftyRSA

struct TestError: Error {
    let description: String
}

// swiftlint:disable force_try
// swiftlint:disable force_unwrapping
@objc open class TestUtils: NSObject {
    
    static let bundle = Bundle(for: TestUtils.self)
    
    static open func pemKeyString(_ name: String) -> String {
        let pubPath = bundle.path(forResource: name, ofType: "pem")!
        return (try! NSString(contentsOfFile: pubPath, encoding: String.Encoding.utf8.rawValue)) as String
    }
    
    static open func derKeyData(_ name: String) -> Data {
        let pubPath  = bundle.path(forResource: name, ofType: "der")!
        return (try! Data(contentsOf: URL(fileURLWithPath: pubPath)))
    }
    
    static open func publicKey(_ name: String) throws -> PublicKey {
        guard let path = bundle.path(forResource: name, ofType: "pem") else {
            throw TestError(description: "Couldn't load key for provided path")
        }
        let pemString = try String(contentsOf: URL(fileURLWithPath: path))
        return try PublicKey(pemEncoded: pemString)
    }
    
    static open func privateKey(_ name: String) throws -> PrivateKey {
        guard let path = bundle.path(forResource: name, ofType: "pem") else {
            throw TestError(description: "Couldn't load key for provided path")
        }
        let pemString = try String(contentsOf: URL(fileURLWithPath: path))
        return try PrivateKey(pemEncoded: pemString)
    }
    
    static open func randomData(_ count: Int) -> Data {
        var data = Data(capacity: count)
        data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>) -> Void in
            _ = SecRandomCopyBytes(kSecRandomDefault, count, bytes)
        }
        return data
    }
}
// swiftlint:enable force_try
// swiftlint:enable force_unwrapping
