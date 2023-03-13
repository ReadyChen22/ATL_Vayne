//
//  DetailVCViewModel.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/13.
//

import Foundation

import Foundation
import SwiftyJSON

class DetailVCViewModel {
    
    var onRequestEnd: ((_ user: User) -> Void)?
    
    func prepareRequest(login: String) {
        Api.shared.apiUserDetail(login: login, postData: nil) { (success, msg, data, statusCode) in
            DispatchQueue.main.async { [weak self] in
                guard self != nil else { return }
                let user = User()
                if success {
                    if let data = data {
                        do {
                            let jObj = try JSON(data: data)
                            user.login = jObj["login"].stringValue
                            user.avatar_url = jObj["avatar_url"].stringValue
                            user.html_url = jObj["html_url"].stringValue
                            user.name = jObj["name"].stringValue
                            user.location = jObj["location"].stringValue
                            user.email = jObj["email"].stringValue
                            user.site_admin = jObj["site_admin"].boolValue
                            user.blog = jObj["blog"].stringValue
                        } catch {
                            // mError(error)
                        }
                    }
                }
                self!.onRequestEnd?(user)
            }
        }
    }
}

class User {
    var avatar_url: String = ""
    var name: String = ""
    var login: String = ""
    var html_url: String = ""
    
    var site_admin: Bool = false
    var location: String = ""
    var email: String = ""
    var blog: String = ""
}
