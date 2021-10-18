//
//  PgyService.swift
//  RainBowBridge
//
//  Created by Julian on 2021/10/13.
//

import Foundation
import Moya

enum PgyService {
    case obtainAppAllVersion(_ apiKey: String, appKey: String)
}

// 请求配置
extension PgyService: TargetType {
    // 服务器地址
    public var baseURL: URL {
        return URL(string: "https://www.pgyer.com/apiv2")!
    }

    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .obtainAppAllVersion(_, appKey: _):
            return "/app/builds"
        }
    }

    // 请求类型
    public var method: Moya.Method {
        return .post
    }

    var parameters: [String: Any]? {
        switch self {
        case let .obtainAppAllVersion(apiKey, appKey):
            return ["_api_key": apiKey, "appKey": appKey]
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
    }
    
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }

    // 请求头
    public var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
