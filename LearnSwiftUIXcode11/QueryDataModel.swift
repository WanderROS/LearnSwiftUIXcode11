//
//  QueryDataModel.swift
//  dev
//
//  Created by wander on 2021/10/27.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import Combine

// MARK：- 数据结构
struct JSONData: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
// MARK：- 错误枚举
enum NetworkError: Error {
    case someError
}
 
// MARK：- 网络数据处理类
class NetworkService {
    static let shared = NetworkService()
    private init() { }
    
    var cancellables = Set<AnyCancellable>()
 
    // @escaping closure的写法
    func getWebDataNormal(completion: @escaping (Result<String, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
            .print("_webdata_")
            .filter { ($0.response as! HTTPURLResponse).statusCode == 200 }
            .map { $0.data }
            .decode(type: JSONData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                    print("Received completion (sink)", completion)
            }, receiveValue: { value in
                    print("Received value (sink)", value)
                    completion(.success(value.title))
            }).store(in: &self.cancellables)
    }
 
    // Combine Future的写法
    func getWebData() -> Future<String, Error> {
        return Future() { [weak self] promise in
            if let self = self {
                URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
                    .print("_webdata_")
                    .filter { ($0.response as! HTTPURLResponse).statusCode == 200 }
                    .map { $0.data }
                    .decode(type: JSONData.self, decoder: JSONDecoder())
                   .sink(receiveCompletion: { completion in
                            print("Received completion (sink)", completion)
                    }, receiveValue: { value in
                            print("Received value (sink)", value)
                            promise(.success(value.title))
                    })
                    .store(in: &self.cancellables)
            }
        }
    }
}
