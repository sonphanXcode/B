//
// InitConfirmInquiryResponseDto.swift
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

/** Data */
public struct InitConfirmInquiryResponseDto: Codable, Responseable, JSONEncodable, Hashable {

    public var transaction: TransactionInquiry?
    public var successfulTransactions: [TransactionResDetail]?
    public var failedTransactions: [TransactionResDetail]?

    public init(transaction: TransactionInquiry? = nil, successfulTransactions: [TransactionResDetail]? = nil, failedTransactions: [TransactionResDetail]? = nil) {
        self.transaction = transaction
        self.successfulTransactions = successfulTransactions
        self.failedTransactions = failedTransactions
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case transaction
        case successfulTransactions
        case failedTransactions
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        transaction = container.decodeIfPresent(.transaction)
        successfulTransactions = container.decodeIfPresent(.successfulTransactions)
        failedTransactions = container.decodeIfPresent(.failedTransactions)
       
    }
    
}

extension InitConfirmInquiryResponseDto: Emptyable {
    public static var empty: InitConfirmInquiryResponseDto {
        return .init(transaction: nil, successfulTransactions: nil, failedTransactions: nil)
    }
}
