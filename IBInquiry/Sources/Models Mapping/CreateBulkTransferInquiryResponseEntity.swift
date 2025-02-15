//
//  CreateBulkTransferInquiryResponseEntity.swift
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

/** Data */
public struct CreateBulkTransferInquiryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var inquiryReson: String?
    public var inquiryDesc: String?
    public var totalRow: String?
    public var amount: Double?
    public var ccy: String?
    public var debitAccNo: String?
    public var debitAccName: String?
    public var id: String?
    public var prodCode: String?
    public var txnType: String?
    public var status: String?
    public var effDate: String?
    public var remark: String?
    
}

extension CreateBulkTransferInquiryResponseEntity: Emptyable {
    public static var empty: CreateBulkTransferInquiryResponseEntity {
        return .init(inquiryReson: nil, inquiryDesc: nil, totalRow: nil, amount: nil, ccy: nil, debitAccNo: nil, debitAccName: nil, id: nil, prodCode: nil, txnType: nil, status: nil, effDate: nil, remark: nil)
    }
}
