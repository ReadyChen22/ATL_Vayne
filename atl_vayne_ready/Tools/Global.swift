//
//  Global.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/12.
//

import Foundation

class Global:NSObject {
    
    class var shared: Global {
        struct Singleton{
            static let instance:Global = Global()
        }
        return Singleton.instance
    }
    
    override init(){
        super.init()
    }
    
    let apiSvr = "https://api.github.com"
    let bearerToken = "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"
}
