//
// TxnInquiryListTransferRequestDto.swift
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

public struct TxnInquiryListTransferRequestDto: Codable, Responseable, JSONEncodable, Hashable {

    static let idRule = StringRule(minLength: 0, maxLength: 50, pattern: nil)
    static let txnTypeRule = StringRule(minLength: 0, maxLength: 30, pattern: nil)
    static let benAccNameRule = StringRule(minLength: 0, maxLength: 20, pattern: "/^[A-Za-z0-9]{0,20}$/")
    static let benAccNoRule = StringRule(minLength: 0, maxLength: 20, pattern: "/^[A-Za-z0-9]{0,20}$/")
    static let createdByRule = StringRule(minLength: 0, maxLength: 30, pattern: nil)
    static let keywordRule = StringRule(minLength: 0, maxLength: 4000, pattern: nil)
    public var orders: [Order]?
    public var filters: [Filter]?
    public var page: Page?
    public var id: String?
    public var effDateFrom: String?
    public var effDateTo: String?
    public var txnType: String?
    public var status: [String]?
    public var benAccName: String?
    public var benAccNo: String?
    public var createdBy: String?
    public var keyword: String?

    public init(orders: [Order]? = nil, filters: [Filter]? = nil, page: Page? = nil, id: String? = nil, effDateFrom: String? = nil, effDateTo: String? = nil, txnType: String? = nil, status: [String]? = nil, benAccName: String? = nil, benAccNo: String? = nil, createdBy: String? = nil, keyword: String? = nil) {
        self.orders = orders
        self.filters = filters
        self.page = page
        self.id = id
        self.effDateFrom = effDateFrom
        self.effDateTo = effDateTo
        self.txnType = txnType
        self.status = status
        self.benAccName = benAccName
        self.benAccNo = benAccNo
        self.createdBy = createdBy
        self.keyword = keyword
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case orders
        case filters
        case page
        case id
        case effDateFrom
        case effDateTo
        case txnType
        case status
        case benAccName
        case benAccNo
        case createdBy
        case keyword
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orders = container.decodeIfPresent(.orders)
        filters = container.decodeIfPresent(.filters)
        page = container.decodeIfPresent(.page)
        id = container.decodeIfPresent(.id)
        effDateFrom = container.decodeIfPresent(.effDateFrom)
        effDateTo = container.decodeIfPresent(.effDateTo)
        txnType = container.decodeIfPresent(.txnType)
        status = container.decodeIfPresent(.status)
        benAccName = container.decodeIfPresent(.benAccName)
        benAccNo = container.decodeIfPresent(.benAccNo)
        createdBy = container.decodeIfPresent(.createdBy)
        keyword = container.decodeIfPresent(.keyword)
       
    }
    
}

extension TxnInquiryListTransferRequestDto: Emptyable {
    public static var empty: TxnInquiryListTransferRequestDto {
        return .init(orders: nil, filters: nil, page: nil, id: nil, effDateFrom: nil, effDateTo: nil, txnType: nil, status: nil, benAccName: nil, benAccNo: nil, createdBy: nil, keyword: nil)
    }
}
