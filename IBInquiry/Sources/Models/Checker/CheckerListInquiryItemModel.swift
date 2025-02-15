//
//  CheckerListInquiryItemModel.swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBResources

public struct CheckerListInquiryItemModel: Equatable & Hashable {
     var id: String
     var orgId: String
     var txnType: String
     var status: String
     var createdDate: String
     var createdBy: String
     var approvedBy: String
     var inquiryReason: String
     var amount: Int64
     var ccy: String

    init(item: TxnInquiryResponseEntity) {
        self.id = item.id ?? ""
        self.orgId = item.orgId ?? ""
        self.txnType = item.txnType ?? ""
        self.status = item.status ?? ""
        self.createdDate = item.createdDate?.convertDateFormat() ?? ""
        self.createdBy = item.createdBy ?? ""
        self.approvedBy = item.approvedBy ?? ""
        self.inquiryReason = item.inquiryReason ?? ""
        self.amount = item.amount ?? 0
        self.ccy = item.ccy ?? ""
    }
}
