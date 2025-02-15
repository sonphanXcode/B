//
//  TxnInquiryListRequestEntity.swift
//  IBInquiry
//
//  Created by tran dinh quy on 10/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBCommon
import IBFoundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct TxnInquiryListRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

    static let inquiryReasonRule = StringRule(minLength: 0, maxLength: 30, pattern: nil)
    static let createdByRule = StringRule(minLength: 0, maxLength: 30, pattern: nil)
    static let keywordRule = StringRule(minLength: 0, maxLength: 4000, pattern: nil)
    public var orders: [OrderEntity]?
    public var filters: [FilterEntity]?
    public var page: PageEntity?
    public var createdDateFrom: String?
    public var createdDateTo: String?
    public var txnType: [String]?
    public var inquiryReason: String?
    public var createdBy: String?
    public var status: [String]?
    public var keyword: String?

}

extension TxnInquiryListRequestEntity: Emptyable {
    public static var empty: TxnInquiryListRequestEntity {
        return .init(orders: nil, filters: nil, page: nil, createdDateFrom: nil, createdDateTo: nil, txnType: nil, inquiryReason: nil, createdBy: nil, status: nil, keyword: nil)
    }
}

extension TxnInquiryListRequestEntity {
    public func toDtoModel() -> TxnInquiryListRequestDto {
        let ordersDto: [Order]? = self.orders?.map { $0.toDtoModel() }
        let filterDto: [Filter]? = self.filters?.map { $0.toDtoModel() }
        let pageDto: Page? = self.page?.toDtoModel()
        return TxnInquiryListRequestDto(orders: ordersDto, filters: filterDto, page: pageDto, createdDateFrom: self.createdDateFrom, createdDateTo: self.createdDateFrom, txnType: self.txnType, inquiryReason: self.inquiryReason, createdBy: self.createdBy, status: self.status, keyword: self.keyword)
    }
}
