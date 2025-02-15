//
// TransactionResDetail.swift
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

public struct TransactionResDetail: Codable, Responseable, JSONEncodable, Hashable {

    public var txnId: String
    public var message: String

    public init(txnId: String, message: String) {
        self.txnId = txnId
        self.message = message
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case txnId
        case message
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        txnId = container.decodeIfPresent(.txnId) ?? .empty
        message = container.decodeIfPresent(.message) ?? .empty
       
    }
    
}

extension TransactionResDetail: Emptyable {
    public static var empty: TransactionResDetail {
        return .init(txnId: .empty, message: .empty)
    }
}
