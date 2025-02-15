//
//  MackerListOriginalTransFilterModel.swift
//  IBInquiry
//
//  Created by tran dinh quy on 15/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation

public struct MackerListOriginalTransFilterModel: Codable, Hashable {
    
    var txnType: String?
    var id: String?
    var status: [String]?
    var benAccName: String?
    var benAccNo: String?
    var effDateFrom: String?
    var effDateTo: String?
    var createdBy: String?
    var keyword: String?
    
}

extension MackerListOriginalTransFilterModel {
    public func toMackerListOriginalTransRequestDto() -> TxnInquiryListTransferRequestDto {
        return TxnInquiryListTransferRequestDto(
            orders: nil,
            filters: nil,
            page: nil,
            id: self.id,
            effDateFrom: self.effDateFrom?.isEmpty == false ? self.effDateFrom : nil,
            effDateTo: self.effDateTo?.isEmpty == false ? self.effDateTo : nil,
            txnType: self.txnType,
            status: self.status,
            createdBy: self.createdBy,
            keyword: self.keyword
        )
    }
}
