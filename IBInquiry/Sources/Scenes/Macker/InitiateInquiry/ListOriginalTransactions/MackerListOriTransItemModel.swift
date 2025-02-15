//
//  MackerListOriTransItemModel.swift
//  IBInquiry
//
//  Created by Son phan on 14/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBViewComponents
import IBFeatureCommon

public struct MackerListOriTransItemModel: Equatable & Hashable {
    public var id: String
    public var orgId: String
    public var txnType: String
    public var status: TransactionStatus
    public var createdDate: String
    public var createdBy: String
    public var approvedBy: String
    public var inquiryReason: String
    public var amount: Int64
    public var ccy: String
    
}
