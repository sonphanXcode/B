import Foundation
import IBNetworkInterface
import IBFoundation
import IBCommon
import CasePaths
import IBAuth
import UIKit
import IBInquiry

class IBankAppHeaderDefine: HeaderDefine {
    var acceptLanguage: String = "VI"
    
    var contentType: String {
        "application/json"
    }
    
    var xForwardedFor: String {
        "10.21.101.126"
    }
    
    var channel: String {
        "IBANK2"
    }
    
    var xClientID: String {
        "635bdf50465dce92380c15b9c19d8c51"
    }
    var clientID: String {
        "ibank-mobile"
    }
}

struct AuthenNetworkDefine: IBAuth.AuthenNetworkDefine {
    public static let shared = AuthenNetworkDefine()
    var loginPassword: String = "ibank2/auth/mobile/login"
    
    var loginBio: String = "ibank2/auth/mobile/login"
    
    var refreshToken: String = "ibank2/auth/mobile/refresh-token"
    
    var baseUrl: String = "https://bidv.net:9303/bidvorg/service/open-banking/ibank2-dev"
    
    func isLogin(urlPath: String) -> Bool {
        return urlPath == (baseUrl + loginPassword) || urlPath == (baseUrl + loginBio)
    }
}

public struct BuildConfiguration {
    public static var baseUrl: String = "https://bidv.net:9303/bidvorg/service/open-banking/ibank2-dev"
    public static var xForwardedFor = "10.21.101.126"
    public static var xClientID = "635bdf50465dce92380c15b9c19d8c51"
    public static var iClientID = "APP"
    public static var iVersion = "1.0.0"
    public static var channel = "IBANK2"
    public static var keyGroup: String = "uat keyGroup"
}

struct BehaviorIBInquiry: RequestBehavior {
    @Inject
    var headerDefine: HeaderDefine?
    
    func prepare(_ request: URLRequest) -> URLRequest {
        var newReqest = request
        var headers = newReqest.headers

        if request.url?.absoluteString.contains("ibank2-dev/auth/mobile/login") == true {
            print("prepare request login")
            if let httpBody = newReqest.httpBody {
                if var json = try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any] {
                  json["deviceId"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
                    newReqest.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
                }
            } else {
                let json: [String: Any] = ["deviceId": UIDevice.current.identifierForVendor?.uuidString ?? ""]
                newReqest.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
            }
        }
        
        if let header = headerDefine {
            headers["Content-Type"] = header.contentType
            headers["X-Forwarded-For"] = header.xForwardedFor
            headers["Channel"] = header.channel
            headers["X-Client-ID"] = header.xClientID
            headers["Client-ID"] = header.clientID
            headers["Accept-Language"] = header.acceptLanguage
        }
        headers["Content-Type"] = "application/json"
        headers["X-Forwarded-For"] = BuildConfiguration.xForwardedFor
        headers["Channel"] = BuildConfiguration.channel
        headers["Accept-Language"] = "vi-vn"
        headers["Timestamp"] = ISO8601DateFormatter().string(from: Date())
        headers["X-API-Interaction-ID"] = String((0..<12).compactMap { _ in "0123456789".randomElement() })
        headers["X-Client-ID"] = BuildConfiguration.xClientID
        headers["I-Mobile"] = "True"
        headers["I-Client-ID"] = BuildConfiguration.iClientID
        headers["I-Device-ID"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
        headers["I-Version"] = BuildConfiguration.iVersion
        headers["I-Encrypted"] = "false"
        headers["I-Os"] = "Ios"
        headers["I-Os-Version"] = UIDevice.current.systemVersion
        headers["I-Device-Model"] = UIDevice.current.model

        newReqest.headers = headers
        return newReqest
    }

    func modify(request: URLRequest, response: DataResponse) -> DataResponse {
            // Log URL của request
            if let url = request.url?.absoluteString {
                AppLogger.share.log("URL Response: \(url)")
            }

            if let data = response.data,
               let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                AppLogger.share.log("Response Body: \(jsonString)")
            } else if let data = response.data,
                      let bodyString = String(data: data, encoding: .utf8) {
                // Log plain text body nếu không phải JSON
                AppLogger.share.log("Response Body (Plain Text): \(bodyString)")
            } else {
                AppLogger.share.log("Response Body: Empty or not readable")
            }

            return response
        }

}
