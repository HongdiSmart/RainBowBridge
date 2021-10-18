//
//  ApplicationFlow.swift
//  RainBowBridge
//
//  Created by Julian on 2021/10/13.
//
import Foundation
import Moya
import SwiftyJSON

typealias completion = (Any?, Error?) -> Void

class ApplicationFlow: NSObject {
    static func sync(_ apiKey: String, appKey: String, completion: @escaping completion) {
        let provider = MoyaProvider<PgyService>()
        provider.request(.obtainAppAllVersion(apiKey, appKey: appKey)) { result in
            switch result {
            case let .success(response):

                DispatchQueue.main.async {
                    // 解析数据
                    do {
                        let data = try? response.mapJSON()
                        let json = JSON(data ?? "")
                        debugPrint(json)
                        completion(json["data"]["list"].arrayObject, nil)
                    } catch {
                        debugPrint("数据错误")
                        completion(nil, error)
                    }
                }
                break
            case let .failure(error):
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                break
            }
        }
    }
}
