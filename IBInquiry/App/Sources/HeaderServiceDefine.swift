import Foundation

// end point of api
public protocol IBInquiryNetworkDefineProtocol {
    var baseUrl: String { get }
    var deviceId: String? { get } // fake for test
}

public struct DefaultIBInquiryNetworkDefine: IBInquiryNetworkDefineProtocol {
    public var deviceId: String? = "2864272bc9f108651"
    public static let shared = DefaultIBInquiryNetworkDefine()
    public var baseUrl: String = "https://bidv.net:9303/bidvorg/service/open-banking/ibank2-dev" // for open api
}
