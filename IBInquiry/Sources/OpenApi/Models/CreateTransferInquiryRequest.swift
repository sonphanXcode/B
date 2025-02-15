//
// CreateTransferInquiryRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import IBCommon
import IBFoundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CreateTransferInquiryRequest: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?

    public init(id: String? = nil) {
        self.id = id
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeIfPresent(.id)
       
    }
    
}

extension CreateTransferInquiryRequest: Emptyable {
    public static var empty: CreateTransferInquiryRequest {
        return .init(id: nil)
    }
}
