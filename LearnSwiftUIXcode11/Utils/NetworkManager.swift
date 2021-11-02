//
//  NetworkManager.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/2.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager{
    
    static func loadData(url: URL, completion: @escaping (PostResponse?) -> ()){
        URLSession.shared.dataTask(with: url){
            data,reponse,error in
            guard let data = data,error == nil else{
                completion(nil)
                return
            }
            
            if let response = try? JSONDecoder().decode(PostResponse.self, from: data){
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }.resume()
    }
}
