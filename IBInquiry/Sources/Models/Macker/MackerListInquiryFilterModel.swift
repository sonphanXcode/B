//
//  MackerListInquiryFilterModel.swift
//  IBInquiry
//
//  Created by Son phan on 9/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation

public struct MackerListInquiryFilterModel: Codable, Hashable {
    public var createdDateFrom: String?
    public var createdDateTo: String?
    public var txnType: [String]?
    public var inquiryReason: String?
    public var status: [String]?
    public var keyword: String?
    public var id: String?
    public var effDateFrom: String?
    public var effDateTo: String?
    public var benAccName: String?
    public var benAccNo: String?
    public var createdBy: String?
}

extension MackerListInquiryFilterModel {
    public func toTxnInquiryListRequestDto() -> TxnInquiryListRequestDto {
        return TxnInquiryListRequestDto(
            createdDateFrom: self.createdDateFrom,
            createdDateTo: self.createdDateTo,
            txnType: self.txnType,
            inquiryReason: self.inquiryReason,
            status: self.status,
            keyword: self.keyword
        )
    }
//    public func toTxnInquiryListTransferRequestDto() -> TxnInquiryListTransferRequestDto {
//        return TxnInquiryListTransferRequestDto(
//            orders: nil,
//            filters: nil,
//            page: nil,
//            id: self.id,
//            effDateFrom: self.effDateFrom,
//            effDateTo: self.effDateTo,
//            txnType: self.txnType,
//            status: self.status,
//            benAccName: self.benAccName,
//            benAccNo: self.benAccNo,
//            createdBy: self.createdBy,
//            keyword: self.keyword
//        )
//    }
}
