//
//  MackerListInquiryItemModel.swift
//  IBInquiry
//
//  Created by Son phan on 9/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBViewComponents
import IBFeatureCommon

public enum TransactionStatus: String {
    case approved = "APPROVED"
    case pendingApproval = "PENDING_APPROVAL"
    case future = "FUTURE"
    case `default`
}

public struct MackerListInquiryItemModel: Equatable & Hashable {
    public var id: String?
    public var orgId: String?
    public var txnType: String?
    public var status: TransactionStatus?
    public var createdDate: String?
    public var createdBy: String?
    public var approvedBy: String?
    public var inquiryReason: String?
    public var amount: Int64?
    public var ccy: String?
    public var beneficiaryAccount: String?
    public var beneficiaryName: String?
    public var cardNumber: String?
    public var effectiveDate: String?

    init(from entity: TxnInquiryResponseEntity) {
        self.id = entity.id
        self.orgId = entity.orgId
        self.txnType = entity.txnType
        self.status = TransactionStatus(rawValue: entity.statusCode)
        self.createdDate = entity.createdDate?.convertDateFormat()
        self.createdBy = entity.createdBy?.convertDateFormat()
        self.approvedBy = entity.approvedBy
        self.inquiryReason = entity.inquiryReason
        self.amount = entity.amount
        self.ccy = entity.ccy
        self.beneficiaryAccount = nil
        self.beneficiaryName = nil
        self.cardNumber = nil
        self.effectiveDate = nil
    }

    init(from entity: TxnInquiryListBulkResponseEntity) {
        self.id = entity.id
        self.orgId = nil
        self.txnType = entity.type
        self.status = TransactionStatus(rawValue: entity.status ?? "")
        self.createdDate = entity.effDate
        self.createdBy = nil
        self.approvedBy = nil
        self.inquiryReason = nil 
        self.amount = entity.amount.map { Int64($0) }
        self.ccy = entity.ccy
        self.beneficiaryAccount = entity.benAccNo
        self.beneficiaryName = entity.benName
        self.cardNumber = entity.cardNo
        self.effectiveDate = entity.effDate
    }
}


extension String {
    func convertDateFormat(from inputFormat: String = DateTimeUtils.yyyyMMdd, to outputFormat: String = DateTimeUtils.ddMMyyyy) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        guard let date = inputFormatter.date(from: self) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        
        return outputFormatter.string(from: date)
    }
    
    func formatToISODate(from inputFormat: String = DateTimeUtils.ddMMyyyy, to outputFormat: String = DateTimeUtils.yyyyMMdd) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        
        return outputFormatter.string(from: date)
    }
}
