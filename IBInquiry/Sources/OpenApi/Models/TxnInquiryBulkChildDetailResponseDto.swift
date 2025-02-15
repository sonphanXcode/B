//
// TxnInquiryBulkChildDetailResponseDto.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import IBCommon
import IBFoundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Data */
public struct TxnInquiryBulkChildDetailResponseDto: Codable, Responseable, JSONEncodable, Hashable {

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

    public init(id: String? = nil, status: String? = nil, createdDate: String? = nil, feeTotal: Double? = nil, inquiryReason: String? = nil, inquiryResult: String? = nil, inquiryAnswer: String? = nil, amount: Double? = nil, ccy: String? = nil, debitAccNo: String? = nil, debitAccName: String? = nil, benBankNameShort: String? = nil, benAccNo: String? = nil, benName: String? = nil, orgTxnId: String? = nil, txnType: String? = nil, txnStatus: String? = nil, effDate: String? = nil, remark: String? = nil, bulkId: String? = nil, inquiryDesc: String? = nil) {
        self.id = id
        self.status = status
        self.createdDate = createdDate
        self.feeTotal = feeTotal
        self.inquiryReason = inquiryReason
        self.inquiryResult = inquiryResult
        self.inquiryAnswer = inquiryAnswer
        self.amount = amount
        self.ccy = ccy
        self.debitAccNo = debitAccNo
        self.debitAccName = debitAccName
        self.benBankNameShort = benBankNameShort
        self.benAccNo = benAccNo
        self.benName = benName
        self.orgTxnId = orgTxnId
        self.txnType = txnType
        self.txnStatus = txnStatus
        self.effDate = effDate
        self.remark = remark
        self.bulkId = bulkId
        self.inquiryDesc = inquiryDesc
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case status
        case createdDate
        case feeTotal
        case inquiryReason
        case inquiryResult
        case inquiryAnswer
        case amount
        case ccy
        case debitAccNo
        case debitAccName
        case benBankNameShort
        case benAccNo
        case benName
        case orgTxnId
        case txnType
        case txnStatus
        case effDate
        case remark
        case bulkId
        case inquiryDesc
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeIfPresent(.id)
        status = container.decodeIfPresent(.status)
        createdDate = container.decodeIfPresent(.createdDate)
        feeTotal = container.decodeIfPresent(.feeTotal)
        inquiryReason = container.decodeIfPresent(.inquiryReason)
        inquiryResult = container.decodeIfPresent(.inquiryResult)
        inquiryAnswer = container.decodeIfPresent(.inquiryAnswer)
        amount = container.decodeIfPresent(.amount)
        ccy = container.decodeIfPresent(.ccy)
        debitAccNo = container.decodeIfPresent(.debitAccNo)
        debitAccName = container.decodeIfPresent(.debitAccName)
        benBankNameShort = container.decodeIfPresent(.benBankNameShort)
        benAccNo = container.decodeIfPresent(.benAccNo)
        benName = container.decodeIfPresent(.benName)
        orgTxnId = container.decodeIfPresent(.orgTxnId)
        txnType = container.decodeIfPresent(.txnType)
        txnStatus = container.decodeIfPresent(.txnStatus)
        effDate = container.decodeIfPresent(.effDate)
        remark = container.decodeIfPresent(.remark)
        bulkId = container.decodeIfPresent(.bulkId)
        inquiryDesc = container.decodeIfPresent(.inquiryDesc)
       
    }
    
}

extension TxnInquiryBulkChildDetailResponseDto: Emptyable {
    public static var empty: TxnInquiryBulkChildDetailResponseDto {
        return .init(id: nil, status: nil, createdDate: nil, feeTotal: nil, inquiryReason: nil, inquiryResult: nil, inquiryAnswer: nil, amount: nil, ccy: nil, debitAccNo: nil, debitAccName: nil, benBankNameShort: nil, benAccNo: nil, benName: nil, orgTxnId: nil, txnType: nil, txnStatus: nil, effDate: nil, remark: nil, bulkId: nil, inquiryDesc: nil)
    }
}
