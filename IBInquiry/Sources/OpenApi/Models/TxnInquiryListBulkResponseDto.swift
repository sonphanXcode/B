//
// TxnInquiryListBulkResponseDto.swift
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

/** List data */
public struct TxnInquiryListBulkResponseDto: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?
    public var benAccNo: String?
    public var benName: String?
    public var type: String?
    public var cardNo: String?
    public var effDate: String?
    public var status: String?
    public var amount: Double?
    public var ccy: String?

    public init(id: String? = nil, benAccNo: String? = nil, benName: String? = nil, type: String? = nil, cardNo: String? = nil, effDate: String? = nil, status: String? = nil, amount: Double? = nil, ccy: String? = nil) {
        self.id = id
        self.benAccNo = benAccNo
        self.benName = benName
        self.type = type
        self.cardNo = cardNo
        self.effDate = effDate
        self.status = status
        self.amount = amount
        self.ccy = ccy
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case benAccNo
        case benName
        case type
        case cardNo
        case effDate
        case status
        case amount
        case ccy
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeIfPresent(.id)
        benAccNo = container.decodeIfPresent(.benAccNo)
        benName = container.decodeIfPresent(.benName)
        type = container.decodeIfPresent(.type)
        cardNo = container.decodeIfPresent(.cardNo)
        effDate = container.decodeIfPresent(.effDate)
        status = container.decodeIfPresent(.status)
        amount = container.decodeIfPresent(.amount)
        ccy = container.decodeIfPresent(.ccy)
       
    }
    
}

extension TxnInquiryListBulkResponseDto: Emptyable {
    public static var empty: TxnInquiryListBulkResponseDto {
        return .init(id: nil, benAccNo: nil, benName: nil, type: nil, cardNo: nil, effDate: nil, status: nil, amount: nil, ccy: nil)
    }
}
