//
//  PageEntity.swift
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

public struct PageEntity: Codable, Responseable, JSONEncodable, Hashable {

    static let pageSizeRule = NumericRule<Int>(minimum: 1, exclusiveMinimum: false, maximum: nil, exclusiveMaximum: false, multipleOf: nil)
    static let pageNumRule = NumericRule<Int>(minimum: 1, exclusiveMinimum: false, maximum: nil, exclusiveMaximum: false, multipleOf: nil)
    /** Row number/ page, min = 1 */
    public var pageSize: Int?
    /** Page index (start from 1), min = 1 */
    public var pageNum: Int?
    /** Get total record size flag */
    public var getTotal: Bool?
    
}

extension PageEntity: Emptyable {
    public static var empty: PageEntity {
        return .init(pageSize: nil, pageNum: nil, getTotal: nil)
    }
}

extension PageEntity {
    public func toDtoModel() -> Page {
        Page(pageSize: self.pageSize, pageNum: self.pageNum, getTotal: self.getTotal)
    }
}
