//
//  PostResponse.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/2.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

struct PostResponse: Codable{
    var userId: Int
    var id: Int?
    var title: String?
    var body: String?
}
