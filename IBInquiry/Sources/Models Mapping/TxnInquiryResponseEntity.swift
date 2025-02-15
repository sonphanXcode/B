//
//  TxnInquiryResponseEntity.swift
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

/** List data */
public struct TxnInquiryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {
    
    public var id: String?
    public var orgId: String?
    public var txnType: String?
    public var status: String?
    public var createdDate: String?
    public var createdBy: String?
    public var approvedBy: String?
    public var inquiryReason: String?
    public var amount: Int64?
    public var ccy: String?
    
}

extension TxnInquiryResponseEntity: Emptyable {
    public static var empty: TxnInquiryResponseEntity {
        return .init(id: nil, orgId: nil, txnType: nil, status: nil, createdDate: nil, createdBy: nil, approvedBy: nil, inquiryReason: nil, amount: nil, ccy: nil)
    }
}

extension TxnInquiryResponseDto {
    public func toEntity() -> TxnInquiryResponseEntity {
        TxnInquiryResponseEntity(id: self.id,
                                 orgId: self.orgId,
                                 txnType: self.txnType,
                                 status: self.status,
                                 createdDate: self.createdDate,
                                 createdBy: self.createdBy,
                                 approvedBy: self.approvedBy,
                                 inquiryReason: self.inquiryReason,
                                 amount: self.amount,
                                 ccy: self.ccy)
    }
}
