//
//  CustomQrCodeDataEntity.swift
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
import IBFeatureCommon
import IBResources
#endif

public struct CustomQrCodeDataEntity: Codable, Responseable, JSONEncodable, Hashable {

    public enum QrType: String, Codable, CaseIterable {
        case bidvibankTransOtp = "BIDVIBANK_TRANS_OTP"
        case napas = "NAPAS"
    }
    public var authId: String?
    public var userId: String?
    public var qrType: QrType?
    public var additionalInfo: String?
    public var productName: String?
    public var subProductName: String?
    public var productCode: String?
    public var subProductCode: String?
    public var amount: String?
    public var trans: [QrTransGroupEntity]?
    public var createdBy: String?
    public var totalTrans: Int64?
    
}

extension CustomQrCodeDataEntity: Emptyable {
    public static var empty: CustomQrCodeDataEntity {
        return .init(authId: nil, userId: nil, qrType: nil, additionalInfo: nil, productName: nil, subProductName: nil, productCode: nil, subProductCode: nil, amount: nil, trans: nil, createdBy: nil, totalTrans: nil)
    }
    
    public func getDisplayTransaction() -> DisplayTransactionInfo {
        if trans?.count ?? 0 > 1 {
            let data = MultiTranSignInfo(numberTransaction: Int(totalTrans ?? 0),
                                         type: subProductCode ?? "",
                                         userCreated: createdBy ?? "")
            return .multiple(data)
        } else {
            let currentCode = trans?.first?.ccy ?? IBResourcesStrings.vnd
            let data = SingleTranSign(amount: trans?.first?.amount?.currencyFormat(curCode: currentCode) ?? "",
                                      amountString: trans?.first?.amountText ?? "",
                                      currCode: currentCode,
                                      type: subProductName ?? productName ?? "",
                                      userCreated: createdBy ?? "")
            return .single(data)
        }
    }
}

extension CustomQrCodeDataDto {
    func toEntity() -> CustomQrCodeDataEntity {
        return CustomQrCodeDataEntity(
            authId: self.authId,
            userId: self.userId,
            qrType: self.qrType.flatMap { CustomQrCodeDataEntity.QrType(rawValue: $0.rawValue) },
            additionalInfo: self.additionalInfo,
            productName: self.productName,
            subProductName: self.subProductName,
            productCode: self.productCode,
            subProductCode: self.subProductCode,
            amount: self.amount,
            trans: self.trans?.map { $0.toEntity() },
            createdBy: self.createdBy,
            totalTrans: self.totalTrans
        )
    }
}
