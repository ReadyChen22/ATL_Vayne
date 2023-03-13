//
//  Cipher.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/13.
//

import CryptoSwift

class Cipher: NSObject {

    class func shared() -> Cipher {
        struct Singleton{
            static let instance:Cipher = Cipher()
        }
        return Singleton.instance
    }
    
    //MARK:- CBC AES En
    func aesEn(_ value:String, key:String, iv:String) -> String {
        let inKey: [UInt8] = Array(key.utf8)
        let inIv: [UInt8] = Array(iv.utf8)
        let inValue: [UInt8] = Array(value.utf8)
        let encrypted = try! AES(key: inKey, blockMode: CBC(iv: inIv), padding: .pkcs7).encrypt(inValue)
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDe(_ string: String, key:String, iv:String) -> String {
        let inKey: [UInt8] = Array(key.utf8)
        let inIv: [UInt8] = Array(iv.utf8)
        var dec = "error"
        do {
            let base64Data = Data(base64Encoded: string)!
            let aes = try AES(key: inKey, blockMode: CBC(iv: inIv), padding: .pkcs7)
            let decryptedBytes = try aes.decrypt(base64Data.bytes)
            dec = String(data: Data(bytes: decryptedBytes), encoding: .utf8)!
        } catch let err {
            print("AES decryption error: \(err)")
        }
        return dec
    }
}

