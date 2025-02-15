//
//  DataListCategoryResponseEntity.swift
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
public struct DataListCategoryResponseEntity: Codable, Responseable, JSONEncodable, Hashable {

    /** List data */
    public var items: [CategoryResponseEntity]?
    /** Total size */
    public var total: Int64?
    
}

extension DataListCategoryResponseEntity: Emptyable {
    public static var empty: DataListCategoryResponseEntity {
        return .init(items: nil, total: nil)
    }
}
