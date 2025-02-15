//
// DataListTxnInquiryListTransferResponseDto.swift
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
public struct DataListTxnInquiryListTransferResponseDto: Codable, Responseable, JSONEncodable, Hashable {

    /** List data */
    public var items: [TxnInquiryListTransferResponseDto]?
    /** Total size */
    public var total: Int64?

    public init(items: [TxnInquiryListTransferResponseDto]? = nil, total: Int64? = nil) {
        self.items = items
        self.total = total
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case items
        case total
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = container.decodeIfPresent(.items)
        total = container.decodeIfPresent(.total)
       
    }
    
}

extension DataListTxnInquiryListTransferResponseDto: Emptyable {
    public static var empty: DataListTxnInquiryListTransferResponseDto {
        return .init(items: nil, total: nil)
    }
}
