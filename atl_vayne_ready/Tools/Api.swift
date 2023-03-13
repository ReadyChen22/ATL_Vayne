//
//  Api.swift
//  atl_vayne_ready
//
//  Created by BruceAppRD on 2023/3/12.
//

import Foundation

class Api {
    
    class var shared: Api {
        struct Singleton{
            static let instance:Api = Api()
        }
        return Singleton.instance
    }
    
    func apiListUser(postData: Data?, completion: @escaping (Bool, String, Data?, Int) -> () ) {
        let api = String( format: "/users")
        _ = sessionCore(api: api, httpMethod: "GET", postData: postData) {
            (success, msg, data, statusCode) in
            completion(success, msg, data, statusCode)
        }
    }
    
    func apiUserDetail(login: String, postData: Data?, completion: @escaping (Bool, String, Data?, Int) -> () ) {
        let api = String( format: "/users/%@", login)
        _ = sessionCore(api: api, httpMethod: "GET", postData: postData) {
            (success, msg, data, statusCode) in
            completion(success, msg, data, statusCode)
        }
    }
    
    private func sessionCore(api: String, httpMethod: String, postData: Any?,
                             completion: @escaping (Bool, String, Data?, Int) -> ()) -> URLSessionDataTask {
        let url = URL(string: Global.shared.apiSvr + api)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        if postData != nil {
            request.httpBody = postData as? Data
        }

        let bearerToken = Cipher.shared().aesDe(Global.shared.bearerToken,
                                               key: "1FEYVFm51gR4vxb4MOK1v15j4t377RjS",
                                               iv: "Q8BLzNH796Raucgo")
        request.addValue("Bearer " + bearerToken, forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            var statusCode = -1
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            guard error == nil else {
                completion(false, "0229", data, statusCode)
                return
            }

            guard let data = data else {
                completion(false, "0234", data, statusCode)
                return
            }
            
            if statusCode == 200 {
                completion(true, "success", data, statusCode)
            }
            else if statusCode == 401 {
                // TODO: logout user
                completion(false, "0252", data, statusCode)
            }
            else {
                completion(false, "0271", data, statusCode)
            }
        })
        task.resume()
        return task
    }
}
