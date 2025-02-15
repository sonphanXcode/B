//
//  CheckerDetailInquiryModel.swift
//  IBInquiry
//
//  Created by tran dinh quy on 12/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBResources

public struct CheckerDetailInquiryModel: Codable, Hashable {
    public var id: String?
    public var status: String?
    public var createdDate: String?
    public var feeTotal: Double?
    public var inquiryReason: String?
    public var inquiryResult: String?
    public var inquiryAnswer: String?
    public var totalRow: Double?
    public var amount: Double?
    public var ccy: String?
    public var textAmount: String?
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
    
    public init(dataInquiryTransfer data: TxnInquiryDetailResponseEntity) {
        self.id = data.id
        self.status = TransactionInquiryStatus(rawValue: data.status ?? "")?.status ?? ""
        self.createdDate = data.createdDate?.convertDateFormat()
        self.feeTotal = data.feeTotal
        self.inquiryReason = data.inquiryReason
        self.inquiryResult = data.inquiryResult
        self.inquiryAnswer = data.inquiryAnswer
        self.totalRow = 0
        self.amount = data.amount
        self.ccy = data.ccy
        self.textAmount = ""
        self.debitAccNo = data.debitAccNo
        self.debitAccName = data.debitAccName
        self.benBankNameShort = data.benBankNameShort
        self.benAccNo = data.benAccNo
        self.benName = data.benName
        self.orgTxnId = data.orgTxnId
        self.txnType = data.txnType
        self.txnStatus = data.txnStatus
        self.effDate = data.effDate?.convertDateFormat()
        self.remark = data.remark
        self.bulkId = ""
        self.inquiryDesc = data.inquiryDesc
    }
    
    public init(dataInquiryBulk data: TxnInquiryBulkDetailResponseEntity) {
        self.id = data.id
        self.status = TransactionInquiryStatus(rawValue: data.status ?? "")?.status ?? ""
        self.createdDate = data.createdDate?.convertDateFormat()
        self.feeTotal = data.feeTotal
        self.inquiryReason = data.inquiryReason
        self.inquiryResult = data.inquiryResult
        self.inquiryAnswer = data.inquiryAnswer
        self.totalRow = data.totalRow
        self.amount = data.amount
        self.ccy = data.ccy
        self.textAmount = data.textAmount
        self.debitAccNo = data.debitAccNo
        self.debitAccName = data.debitAccName
        self.benBankNameShort = data.benBankNameShort
        self.benAccNo = data.benAccNo
        self.benName = data.benName
        self.orgTxnId = data.orgTxnId
        self.txnType = data.txnType
        self.txnStatus = data.txnStatus
        self.effDate = data.effDate?.convertDateFormat()
        self.remark = data.remark
        self.bulkId = ""
        self.inquiryDesc = data.inquiryDesc
    }
    
    public init(dataInquiryBulkChild data: TxnInquiryBulkChildDetailResponseEntity) {
        self.id = data.id
        self.status = TransactionInquiryStatus(rawValue: data.status ?? "")?.status ?? ""
        self.createdDate = data.createdDate?.convertDateFormat()
        self.feeTotal = data.feeTotal
        self.inquiryReason = data.inquiryReason
        self.inquiryResult = data.inquiryResult
        self.inquiryAnswer = data.inquiryAnswer
        self.totalRow = 0
        self.amount = data.amount
        self.ccy = data.ccy
        self.textAmount = ""
        self.debitAccNo = data.debitAccNo
        self.debitAccName = data.debitAccName
        self.benBankNameShort = data.benBankNameShort
        self.benAccNo = data.benAccNo
        self.benName = data.benName
        self.orgTxnId = data.orgTxnId
        self.txnType = data.txnType
        self.txnStatus = data.txnStatus
        self.effDate = data.effDate?.convertDateFormat()
        self.remark = data.remark
        self.bulkId = data.bulkId
        self.inquiryDesc = data.inquiryDesc
    }
}
