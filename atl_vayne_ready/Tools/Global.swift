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
    var bearerToken = "DO4ut2Jeu0kWBsluoJ/LPDR3x9ZG031D9RzcoVtVE2TvLLSplNg8F62iHLNXVwBHMMZm8fKOdLaITaOJK/Smln36clloZxNRLk6BnnwT667focHQleKLgrymTuxcnhtt"
}
