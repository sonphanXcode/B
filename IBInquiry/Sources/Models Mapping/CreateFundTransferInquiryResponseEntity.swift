//
//  CreateFundTransferInquiryResponseEntity.swift
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
public struct CreateFundTransferInquiryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var inquiryReson: String?
    public var inquiryDesc: String?
    public var amount: Double?
    public var ccy: String?
    public var debitAccNo: String?
    public var debitAccName: String?
    public var benBankNameShort: String?
    public var benName: String?
    public var benAccNo: String?
    public var benCardno: String?
    public var benId: String?
    public var id: String?
    public var prodCode: String?
    public var txnType: String?
    public var status: String?
    public var effDate: String?
    public var remark: String?
    
}

extension CreateFundTransferInquiryResponseEntity: Emptyable {
    public static var empty: CreateFundTransferInquiryResponseEntity {
        return .init(inquiryReson: nil, inquiryDesc: nil, amount: nil, ccy: nil, debitAccNo: nil, debitAccName: nil, benBankNameShort: nil, benName: nil, benAccNo: nil, benCardno: nil, benId: nil, id: nil, prodCode: nil, txnType: nil, status: nil, effDate: nil, remark: nil)
    }
}

extension CreateFundTransferInquiryResponse {
    public func toEntity() -> CreateFundTransferInquiryResponseEntity {
        return CreateFundTransferInquiryResponseEntity(
            inquiryReson: self.inquiryReson,
            inquiryDesc: self.inquiryDesc,
            amount: self.amount,
            ccy: self.ccy,
            debitAccNo: self.debitAccNo,
            debitAccName: self.debitAccName,
            benBankNameShort: self.benBankNameShort,
            benName: self.benName,
            benAccNo: self.benAccNo,
            benCardno: self.benCardno,
            benId: self.benId,
            id: self.id,
            prodCode: self.prodCode,
            txnType: self.txnType,
            status: self.status,
            effDate: self.effDate,
            remark: self.remark
        )
    }
}
