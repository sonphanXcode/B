//
//  CheckerDetailInquiryStateMachine.swift
//  IBInquiry
//
//  Created by tran dinh quy on 12/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBFeatureCommon
import IBFoundation
import IBViewComponents
import SwiftMacro

public struct CheckerDetailInquiryStateMachine: Equatable {
    public static func creatStateMachine(envi: IBInquiryEnviromentProtocol?, detailType: TransInquiryType)
        -> AsyncStateMachine<CheckerDetailInquiryState, CheckerDetailInquiryAction, CheckerDetailInquiryCommand> {
        let machine = CheckerDetailInquiryMachine.machine()

        return AsyncStateMachine(
            initialState: .init(detail: .idle, reject: .idle, approved: .init(.idle)),
            command: machine.command(for:),
            reduce: machine.reduce(when:on:),
            runtime: Runtime<CheckerDetailInquiryState, CheckerDetailInquiryAction, CheckerDetailInquiryCommand>()
                .effect(sideEffect: CheckerDetailInquiryEffector.mapEffector(envi: envi, detailType: detailType).transform)
        )
    }
}

@EnumPrismWith("action")
public enum CheckerDetailInquiryAction: Equatable, DSLCompatible {
    case detail(action: RequestItemsAction<String, CheckerDetailInquiryModel>)
    case reject(action: RequestItemsAction<ItemsEntity<String>, ConfirmTransRecallResEntity>)
    case approved(action: SingningAction<[String], TxnPaymentRecallEntity>)
}

@EnumPrismWith("command")
public enum CheckerDetailInquiryCommand: DSLCompatible, Equatable {
    case detail(command: RequestItemsCommand<String>)
    case reject(command: RequestItemsCommand<ItemsEntity<String>>)
    case approved(command: SigningCommand<[String]>)
}

public struct CheckerDetailInquiryState: Equatable {
    public var detail: RequestItemsState<String, CheckerDetailInquiryModel>?
    public var reject: RequestItemsState<ItemsEntity<String>, ConfirmTransRecallResEntity>?
    public var approved: SigningState<[String], TxnPaymentRecallEntity>?
    
    public var isLoading: Bool {
        detail?.isLoading ?? false || reject?.isLoading ?? false || approved?.isLoading ?? false
    }

    public var errorMessage: String? {
        if let message = detail?.errorMessage {
            return message
        } else if let message = reject?.errorMessage {
            return message
        } else if let message = approved?.errorMessage {
            return message
        }
        return nil
    }

    public init(
        detail: RequestItemsState<String, CheckerDetailInquiryModel>? = nil,
        reject: RequestItemsState<ItemsEntity<String>, ConfirmTransRecallResEntity>? = nil,
        approved: SigningState<[String], TxnPaymentRecallEntity>? = nil
    ) {
        self.detail = detail
        self.reject = reject
        self.approved = approved
    }
}

public enum CheckerDetailInquiryMachine {
    public static func machine() -> StateMachine<CheckerDetailInquiryState, CheckerDetailInquiryAction, CheckerDetailInquiryCommand> {
        return RequestItemsManchine<String, CheckerDetailInquiryModel>.machine()
            .lift(state: lens(\.detail))
            .lift(event: CheckerDetailInquiryAction.detailPrism)
            .lift(command: CheckerDetailInquiryCommand.detailPrism)
        <> RequestItemsManchine<ItemsEntity<String>, ConfirmTransRecallResEntity>.machine()
            .lift(state: lens(\.reject))
            .lift(event: CheckerDetailInquiryAction.rejectPrism)
            .lift(command: CheckerDetailInquiryCommand.rejectPrism)
        <> TransactionSigningMachine.machine()
            .lift(state: lens(\.approved))
            .lift(event: CheckerDetailInquiryAction.approvedPrism)
            .lift(command: CheckerDetailInquiryCommand.approvedPrism)
    }
}
