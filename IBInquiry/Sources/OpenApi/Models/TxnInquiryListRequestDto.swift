//
// TxnInquiryListRequestDto.swift
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

public struct TxnInquiryListRequestDto: Codable, Responseable, JSONEncodable, Hashable {

    static let inquiryReasonRule = StringRule(minLength: 0, maxLength: 30, pattern: nil)
    static let createdByRule = StringRule(minLength: 0, maxLength: 30, pattern: nil)
    static let keywordRule = StringRule(minLength: 0, maxLength: 4000, pattern: nil)
    public var orders: [Order]?
    public var filters: [Filter]?
    public var page: Page?
    public var createdDateFrom: String?
    public var createdDateTo: String?
    public var txnType: [String]?
    public var inquiryReason: String?
    public var createdBy: String?
    public var status: [String]?
    public var keyword: String?

    public init(orders: [Order]? = nil, filters: [Filter]? = nil, page: Page? = nil, createdDateFrom: String? = nil, createdDateTo: String? = nil, txnType: [String]? = nil, inquiryReason: String? = nil, createdBy: String? = nil, status: [String]? = nil, keyword: String? = nil) {
        self.orders = orders
        self.filters = filters
        self.page = page
        self.createdDateFrom = createdDateFrom
        self.createdDateTo = createdDateTo
        self.txnType = txnType
        self.inquiryReason = inquiryReason
        self.createdBy = createdBy
        self.status = status
        self.keyword = keyword
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case orders
        case filters
        case page
        case createdDateFrom
        case createdDateTo
        case txnType
        case inquiryReason
        case createdBy
        case status
        case keyword
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orders = container.decodeIfPresent(.orders)
        filters = container.decodeIfPresent(.filters)
        page = container.decodeIfPresent(.page)
        createdDateFrom = container.decodeIfPresent(.createdDateFrom)
        createdDateTo = container.decodeIfPresent(.createdDateTo)
        txnType = container.decodeIfPresent(.txnType)
        inquiryReason = container.decodeIfPresent(.inquiryReason)
        createdBy = container.decodeIfPresent(.createdBy)
        status = container.decodeIfPresent(.status)
        keyword = container.decodeIfPresent(.keyword)
       
    }
    
}

extension TxnInquiryListRequestDto: Emptyable {
    public static var empty: TxnInquiryListRequestDto {
        return .init(orders: nil, filters: nil, page: nil, createdDateFrom: nil, createdDateTo: nil, txnType: nil, inquiryReason: nil, createdBy: nil, status: nil, keyword: nil)
    }
}
