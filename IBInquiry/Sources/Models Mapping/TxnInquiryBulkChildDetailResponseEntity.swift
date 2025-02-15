//
//  TxnInquiryBulkChildDetailResponseEntity.swift
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
public struct TxnInquiryBulkChildDetailResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var id: String?
    public var status: String?
    public var createdDate: String?
    public var feeTotal: Double?
    public var inquiryReason: String?
    public var inquiryResult: String?
    public var inquiryAnswer: String?
    public var amount: Double?
    public var ccy: String?
    public var debitAccNo: String?
    public var debitAccName: String?
    public var benBankNameShort: String?
    public var benAccNo: String?
    public var benName: String?
    public var orgTxnId: String?
    public var txnType: String?
    public var txnStatus: String?
    public var effDate: String?
    public var remark: String?
    public var bulkId: String?
    public var inquiryDesc: String?

}

extension TxnInquiryBulkChildDetailResponseEntity: Emptyable {
    public static var empty: TxnInquiryBulkChildDetailResponseEntity {
        return .init(id: nil, status: nil, createdDate: nil, feeTotal: nil, inquiryReason: nil, inquiryResult: nil, inquiryAnswer: nil, amount: nil, ccy: nil, debitAccNo: nil, debitAccName: nil, benBankNameShort: nil, benAccNo: nil, benName: nil, orgTxnId: nil, txnType: nil, txnStatus: nil, effDate: nil, remark: nil, bulkId: nil, inquiryDesc: nil)
    }
}

public extension TxnInquiryBulkChildDetailResponseDto {
    func toEntity() -> TxnInquiryBulkChildDetailResponseEntity {
        return TxnInquiryBulkChildDetailResponseEntity(
            id: self.id,
            status: self.status,
            createdDate: self.createdDate,
            feeTotal: self.feeTotal,
            inquiryReason: self.inquiryReason,
            inquiryResult: self.inquiryResult,
            inquiryAnswer: self.inquiryAnswer,
            amount: self.amount,
            ccy: self.ccy,
            debitAccNo: self.debitAccNo,
            debitAccName: self.debitAccName,
            benBankNameShort: self.benBankNameShort,
            benAccNo: self.benAccNo,
            benName: self.benName,
            orgTxnId: self.orgTxnId,
            txnType: self.txnType,
            txnStatus: self.txnStatus,
            effDate: self.effDate,
            remark: self.remark,
            bulkId: self.bulkId,
            inquiryDesc: self.inquiryDesc
        )
    }
}
