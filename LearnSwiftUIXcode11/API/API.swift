//
//  API.swift
//  LearnSwiftUIXcode11
//
//  Created by Wander on 2021/11/11.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import Moya


enum API{
    case updateAPi(parameters:[String:Any])
    case register(email:String,password:String)
    //上传用户头像
    case uploadHeadImage(parameters: [String:Any],imageDate:Data)
    case easyRequset
    case foodImage
}

extension API:TargetType{
    var baseURL: URL {
        switch self {
        case .easyRequset:
            return URL.init(string:"http://news-at.zhihu.com/api/")!
        case .foodImage:
            return URL.init(string: "https://source.unsplash.com/")!
        default:
            return URL.init(string:(Moya_baseURL))!
        }
    }
    
    var path: String {
        switch self {
        case .register:
            return "register"
        case .easyRequset:
            return "4/news/latest"
        case .updateAPi:
            return "versionService.getAppUpdateApi"
        case .uploadHeadImage( _):
            return "/file/user/upload.jhtml"
        case .foodImage:
            return "720x450/?food"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .easyRequset,.foodImage:
            return .get
        default:
            return .post
        }
    }
    
    
    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    //    此变量是API请求的方式,把参数之类的传进来
    var task: Task {
        //        return .requestParameters(parameters: nil, encoding: JSONArrayEncoding.default)
        switch self {
        case let .register(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .easyRequset:
            return .requestPlain
        case let .updateAPi(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        //图片上传
        case .uploadHeadImage(let parameters, let imageDate):
            ///name 和fileName 看后台怎么说，   mineType根据文件类型上百度查对应的mineType
            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
                                             fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .foodImage:
            return .requestPlain
        }
        //可选参数https://github.com/Moya/Moya/blob/master/docs_CN/Examples/OptionalParameters.md
        //        case .users(let limit):
        //        var params: [String: Any] = [:]
        //        params["limit"] = limit
        //        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
}
