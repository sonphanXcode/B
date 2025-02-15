//
//  TxnPrintRequestEntity.swift
//  IBInquiry
//
//  Created by Son phan on 12/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBCommon
import IBFoundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct TxnPrintRequestEntity: Codable, Responseable, JSONEncodable, Hashable {
    
    public var id: [String]?
}
