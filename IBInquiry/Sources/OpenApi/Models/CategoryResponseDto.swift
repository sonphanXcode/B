//
// CategoryResponseDto.swift
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

/** List data */
public struct CategoryResponseDto: Codable, Responseable, JSONEncodable, Hashable {

    public var code: String?
    public var name: String?
    public var type: String?

    public init(code: String? = nil, name: String? = nil, type: String? = nil) {
        self.code = code
        self.name = name
        self.type = type
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case code
        case name
        case type
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = container.decodeIfPresent(.code)
        name = container.decodeIfPresent(.name)
        type = container.decodeIfPresent(.type)
       
    }
    
}

extension CategoryResponseDto: Emptyable {
    public static var empty: CategoryResponseDto {
        return .init(code: nil, name: nil, type: nil)
    }
}
