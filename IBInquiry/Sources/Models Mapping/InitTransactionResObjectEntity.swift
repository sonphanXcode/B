//
//  InitTransactionResObjectEntity.swift
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
#endif

/** Data */
public struct InitTransactionResObjectEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var transKey: String?
    public var transaction: AnyCodable?
    public var requireAuth: Bool?
    public var transAuth: TransAuthEntity?
    public var confirmUrl: String?
    
}

extension InitTransactionResObjectEntity: Emptyable {
    public static var empty: InitTransactionResObjectEntity {
        return .init(transKey: nil, transaction: nil, requireAuth: nil, transAuth: nil, confirmUrl: nil)
    }
}

extension InitTransactionResObject {
    func toEntity() -> InitTransactionResObjectEntity {
        return InitTransactionResObjectEntity(
            transKey: self.transKey,
            transaction: self.transaction,
            requireAuth: self.requireAuth,
            transAuth: self.transAuth?.toEntity(),
            confirmUrl: self.confirmUrl
        )
    }
}

extension InitTransactionResObjectEntity {
    public func toSignInfo() -> SignInfo {
            var signInfo = DisplayTransactionInfo.other
            if let additionalInfo = transAuth?.additionalInfo {
                signInfo = additionalInfo.getDisplayTransaction()
            }
            let result = SignInfo(
                type: transAuth?.authType ?? "",
                id: transAuth?.authId ?? "",
                sign: transAuth?.dataSign ?? "",
                qr: transAuth?.qrData ?? "",
                transKey: transKey ?? "",
                isSameDevice: transAuth?.isSameDevice ?? "",
                expTime: String(transAuth?.expTime ?? 0),
                userId: Int(transAuth?.additionalInfo?.userId ?? "0"),
                signType: signInfo)

            return result
        }
}
