//
// ResultTxnInquiryBulkChildDetailResponseDto.swift
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

public struct ResultTxnInquiryBulkChildDetailResponseDto: Codable, Responseable, JSONEncodable, Hashable {

    /** Result status */
    public var status: Int?
    /** Result code detail */
    public var code: String?
    /** Result code description */
    public var message: String?
    /** Addition Error List */
    public var errors: [ResponseError]?
    /** Trace ID */
    public var traceId: String?
    public var data: TxnInquiryBulkChildDetailResponseDto?

    public init(status: Int? = nil, code: String? = nil, message: String? = nil, errors: [ResponseError]? = nil, traceId: String? = nil, data: TxnInquiryBulkChildDetailResponseDto? = nil) {
        self.status = status
        self.code = code
        self.message = message
        self.errors = errors
        self.traceId = traceId
        self.data = data
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case status
        case code
        case message
        case errors
        case traceId
        case data
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = container.decodeIfPresent(.status)
        code = container.decodeIfPresent(.code)
        message = container.decodeIfPresent(.message)
        errors = container.decodeIfPresent(.errors)
        traceId = container.decodeIfPresent(.traceId)
        data = container.decodeIfPresent(.data)
       
    }
    
}

extension ResultTxnInquiryBulkChildDetailResponseDto: Emptyable {
    public static var empty: ResultTxnInquiryBulkChildDetailResponseDto {
        return .init(status: nil, code: nil, message: nil, errors: nil, traceId: nil, data: nil)
    }
}
