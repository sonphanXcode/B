//
//  TransAuthEntity.swift
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

public struct TransAuthEntity: Codable, Responseable, JSONEncodable, Hashable {

    public var authType: String?
    public var expTime: Int64?
    public var isSameDevice: String?
    public var qrData: String?
    public var authId: String?
    public var dataSign: String?
    public var additionalInfo: CustomQrCodeDataEntity?
    
}

extension TransAuthEntity: Emptyable {
    public static var empty: TransAuthEntity {
        return .init(authType: nil, expTime: nil, isSameDevice: nil, qrData: nil, authId: nil, dataSign: nil, additionalInfo: nil)
    }
}

extension TransAuth {
    func toEntity() -> TransAuthEntity {
        return TransAuthEntity(
            authType: self.authType,
            expTime: self.expTime,
            isSameDevice: self.isSameDevice,
            qrData: self.qrData,
            authId: self.authId,
            dataSign: self.dataSign,
            additionalInfo: self.additionalInfo?.toEntity()
        )
    }
}
