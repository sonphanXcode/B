//
// Page.swift
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

public struct Page: Codable, Responseable, JSONEncodable, Hashable {

    static let pageSizeRule = NumericRule<Int>(minimum: 1, exclusiveMinimum: false, maximum: nil, exclusiveMaximum: false, multipleOf: nil)
    static let pageNumRule = NumericRule<Int>(minimum: 1, exclusiveMinimum: false, maximum: nil, exclusiveMaximum: false, multipleOf: nil)
    /** Row number/ page, min = 1 */
    public var pageSize: Int?
    /** Page index (start from 1), min = 1 */
    public var pageNum: Int?
    /** Get total record size flag */
    public var getTotal: Bool?

    public init(pageSize: Int? = nil, pageNum: Int? = nil, getTotal: Bool? = nil) {
        self.pageSize = pageSize
        self.pageNum = pageNum
        self.getTotal = getTotal
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case pageSize
        case pageNum
        case getTotal
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pageSize = container.decodeIfPresent(.pageSize)
        pageNum = container.decodeIfPresent(.pageNum)
        getTotal = container.decodeIfPresent(.getTotal)
       
    }
    
}

extension Page: Emptyable {
    public static var empty: Page {
        return .init(pageSize: nil, pageNum: nil, getTotal: nil)
    }
}
