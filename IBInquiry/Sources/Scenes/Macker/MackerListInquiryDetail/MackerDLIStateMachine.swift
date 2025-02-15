//
//  MackerDLIStateMachine.swift
//  IBInquiry
//
//  Created by Son phan on 11/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBFeatureCommon
import IBFoundation
import IBViewComponents
import SwiftMacro

/// Macker Detail List Inquiry State Machine
public struct MackerDLIStateMachine: Equatable {
    public static func creatStateMachine(envi: IBInquiryEnviromentProtocol?, detailType: TransInquiryType)
        -> AsyncStateMachine<MackerDLIState, MackerDLIAction, MackerDLICommand> {
        let machine = DetailTransactionMachine.machine()

        return AsyncStateMachine(
            initialState: .init(detail: .idle/*, signing: .init(.idle), reject: .idle, approved: .init(.idle)*/),
            command: machine.command(for:),
            reduce: machine.reduce(when:on:),
            runtime: Runtime<MackerDLIState, MackerDLIAction, MackerDLICommand>()
                .effect(sideEffect: MackerDetailListInquiryEffector.mapEffector(envi: envi, detailType: detailType).transform)
        )
    }
}

@EnumPrismWith("action")
public enum MackerDLIAction: Equatable, DSLCompatible {
    case detail(action: RequestItemsAction<String, TxnInquiryDetailResponseEntity>)
//    case reject(action: RequestItemsAction<ItemsEntity<String>, ConfirmTransRecallResEntity>)
//    case signing(action: SingningAction<InitRecallTransferReqEntity, TxnPaymentRecallEntity>)
//    case approved(action: SingningAction<[String], TxnPaymentRecallEntity>)
}

@EnumPrismWith("command")
public enum MackerDLICommand: DSLCompatible, Equatable {
    case detail(command: RequestItemsCommand<String>)
//    case reject(command: RequestItemsCommand<ItemsEntity<String>>)
//    case signing(command: SigningCommand<InitRecallTransferReqEntity>)
//    case approved(command: SigningCommand<[String]>)
}

public struct MackerDLIState: Equatable {
    public var detail: RequestItemsState<String, TxnInquiryDetailResponseEntity>?
//    public var reject: RequestItemsState<ItemsEntity<String>, ConfirmTransRecallResEntity>?
//    public var signing: SigningState<InitRecallTransferReqEntity, TxnPaymentRecallEntity>?
//    public var approved: SigningState<[String], TxnPaymentRecallEntity>?
    
    public var isLoading: Bool {
        detail?.isLoading ?? false /*|| signing?.isLoading ?? false || approved?.isLoading ?? false*/
    }

    public var errorMessage: String? {
        if let message = detail?.errorMessage {
            return message
        }
//        } else if let message = signing?.errorMessage {
//            return message
//        } else if let message = reject?.errorMessage {
//            return message
//        } else if let message = approved?.errorMessage {
//            return message
//        }
        return nil
    }

    public init(
        detail: RequestItemsState<String, TxnInquiryDetailResponseEntity>? = nil
//        signing: SigningState<InitRecallTransferReqEntity, TxnPaymentRecallEntity>? = nil,
//        reject: RequestItemsState<ItemsEntity<String>, ConfirmTransRecallResEntity>? = nil,
//        approved: SigningState<[String], TxnPaymentRecallEntity>? = nil
    ) {
        self.detail = detail
//        self.signing = signing
//        self.reject = reject
//        self.approved = approved
    }
}

public enum DetailTransactionMachine {
    public static func machine() -> StateMachine<MackerDLIState, MackerDLIAction, MackerDLICommand> {
        return RequestItemsManchine<String, TxnInquiryDetailResponseEntity>.machine()
            .lift(state: lens(\.detail))
            .lift(event: MackerDLIAction.detailPrism)
            .lift(command: MackerDLICommand.detailPrism)
//        <> RequestItemsManchine<ItemsEntity<String>, ConfirmTransRecallResEntity>.machine()
//            .lift(state: lens(\.reject))
//            .lift(event: DetailTransactionAction.rejectPrism)
//            .lift(command: DetailTransactionCommand.rejectPrism)
//        <> TransactionSigningMachine.machine()
//            .lift(state: lens(\.signing))
//            .lift(event: DetailTransactionAction.signingPrism)
//            .lift(command: DetailTransactionCommand.signingPrism)
//        <> TransactionSigningMachine.machine()
//            .lift(state: lens(\.approved))
//            .lift(event: DetailTransactionAction.approvedPrism)
//            .lift(command: DetailTransactionCommand.approvedPrism)
    }
}

