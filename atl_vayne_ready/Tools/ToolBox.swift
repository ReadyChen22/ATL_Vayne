//
//  ToolBox.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/13.
//

import Foundation
import UIKit
import SwifterSwift
import SDWebImage

class ToolBox {
    
    class func randomString(min: Int, max: Int ) -> String {
        let iRandLength = min + Int(arc4random_uniform(UInt32(max - min + 1)))
        return String.random(ofLength: iRandLength)
    }
    
    class func ivLoadUrl(iv:UIImageView, url strUrl:String, placeHolder: String = "iv_placeholder"){
        let iv_placeholder = UIImage(named: placeHolder)
        if let url = URL(string: strUrl) {
            iv.sd_setImage(
                with: url,
                placeholderImage: iv_placeholder,
                completed: { image, error, cacheType, imageURL in
                    if error != nil || image == nil {
                        dLog("❌"+error.debugDescription+"❌")
                        iv.image = iv_placeholder
                    } else {
                        iv.image = image
                    }
                })
        } else {
            iv.image = iv_placeholder
        }
    }
}
