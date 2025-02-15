//
//  CheckerListInquiryFilterModel.swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation

public struct CheckerListInquiryFilterModel: Codable, Hashable {
    
    public var orders: [OrderEntity]?
    public var filters: [FilterEntity]?
    public var page: PageEntity?
    var txnType: [String]?
    var inquiryReason: String?
    var createdDateFrom: String?
    var createdDateTo: String?
    var createdBy: String?
    var keyword: String?
    
}

extension CheckerListInquiryFilterModel {
    public func toInquiryCheckerRequestDto() -> TxnInquiryListRequestDto {
        return TxnInquiryListRequestDto(
            orders: nil,
            filters: nil,
            page: nil,
            createdDateFrom: self.createdDateFrom?.isEmpty == false ? self.createdDateFrom : nil,
            createdDateTo: self.createdDateTo?.isEmpty == false ? self.createdDateTo : nil,
            txnType: self.txnType,
            inquiryReason: self.inquiryReason,
            createdBy: self.createdBy,
            keyword: self.keyword
        )
    }
}
