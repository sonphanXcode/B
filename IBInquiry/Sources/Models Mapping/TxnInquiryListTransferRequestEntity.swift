//
//  TxnInquiryListTransferRequestEntity.swift
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

public struct TxnInquiryListTransferRequestEntity: Codable, Responseable, JSONEncodable, Hashable {

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

}

extension TxnInquiryListTransferRequestEntity: Emptyable {
    public static var empty: TxnInquiryListTransferRequestEntity {
        return .init(orders: nil, filters: nil, page: nil, id: nil, effDateFrom: nil, effDateTo: nil, txnType: nil, status: nil, benAccName: nil, benAccNo: nil, createdBy: nil, keyword: nil)
    }
}
