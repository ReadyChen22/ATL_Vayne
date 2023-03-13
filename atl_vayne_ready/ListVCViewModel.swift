//
//  ListVCViewModel.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/13.
//

import Foundation
import SwiftyJSON

class ListVCViewModel {
    
    var onRequestEnd: (() -> Void)?
    
    var listCellViewModels: [ListCellViewModel] = []
    
    func prepareRequest() {
        Api.shared.apiListUser(postData: nil) { (success, msg, data, statusCode) in
            DispatchQueue.main.async { [weak self] in
                guard self != nil else { return }
                if success {
                    if let data = data {
                        do {
                            self!.listCellViewModels.removeAll()
                            let jArr = try JSON(data: data)
                            for (_, subJson):(String, JSON) in jArr {
                                let each = ListCellViewModel()
                                each.id = subJson["id"].intValue
                                each.login = subJson["login"].stringValue
                                each.html_url = subJson["html_url"].stringValue
                                each.avatar_url = subJson["avatar_url"].stringValue
                                self!.listCellViewModels.append(each)
                            }
                        } catch {
                            // mError(error)
                        }
                    }
                }
                self!.onRequestEnd?()
            }
        }
    }
}
