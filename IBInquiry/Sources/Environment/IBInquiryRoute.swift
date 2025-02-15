import IBFoundation
import Foundation
import NavigationCoordinator
import SwiftUI
import MemberwiseInit
import IBDeepLinks
import IBViewComponents
import IBFeatureCommon
import IBResources
import SwiftMacro

public enum IBInquiryRoute {
    case main
    case mackerListTrasInquiy
    case inquiryTransactionChecker
    case inquiryTransactionDetailChecker(id: String, detailType: TransInquiryType)
    case mackerDetailTransInquiry(transId: String, detailType: TransInquiryType)
    case mackerListOriginalTransaction
}

public enum TransInquiryStatus: DSLCompatible, Equatable {
    case all, pendingApproval, waitingForBankResponse, bankResponded, rejected, expired
}

extension IBInquiryRoute: Routable {
    public var ibInquiryEnviroment: IBInquiryEnviromentProtocol? {
        return DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self)
    }
    
    public var type: RouteType {
        switch self {
        case .main:
            return PushRoute(MenuView())
        case .mackerListTrasInquiy:
            return PushRoute(MackerListTransactionView.managerMackerListInquiry(envi: ibInquiryEnviroment))
        case .inquiryTransactionChecker:
            return PushRoute(CheckerListTransactionView.managerCheckerListInquiryView(envi: DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self)))
        case .inquiryTransactionDetailChecker(let id, let detailType):
            return PushRoute(CheckerDetailInquiryView.reactView(transactionId: id, detailType: detailType, envi: ibInquiryEnviroment))
        case .mackerDetailTransInquiry(let id, let detailType):
            return PushRoute(MackerListInquiryDetailView.reactView(transactionId: id, detailType: detailType, envi: ibInquiryEnviroment))
        case .mackerListOriginalTransaction:
            return PushRoute(MackerListTransactionView.managerMackerListOriginalTrans(envi: ibInquiryEnviroment))
        }
    }
}

public enum TransSheet {
    case paymentSelectTransType(selectResult: ([CategoryResponseEntity]) -> Void, selectedItem: [CategoryResponseEntity]?)
    case inquirySelectReason(selectResult: (CategoryResponseEntity) -> Void, selectedItem: CategoryResponseEntity?)
    case inquirySelectType(selectResult: (CategoryResponseEntity) -> Void, selectedItem: CategoryResponseEntity?)
    case inquirySelectMutilStatus(selectResult: ([CategoryResponseEntity]) -> Void, selectedItem: [CategoryResponseEntity]?)
}

extension TransSheet: Sheetable {
    public var paymentRecallEnviroment: IBInquiryEnviromentProtocol? {
        return DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self)
    }
    
    public var sheet: SheetType {
        switch self {
        case .paymentSelectTransType(let selectResult, let selectedItem):
            let selectView = IBSelectedMutilDataView.paymentSelectTransType(result: selectResult, selectedItem: selectedItem ?? [])
            return .fullScreenCorver(selectView)
        case .inquirySelectReason(let selectResult, let selectedItem):
            let selectView = IBSelectedDataView.inquirySelectReason(result: selectResult, selectedItem: selectedItem)
            return .fullScreenCorver(selectView)
        case .inquirySelectType(let selectResult, let selectedItem):
            let selectView = IBSelectedDataView.inquirySelectType(result: selectResult, selectedItem: selectedItem)
            return .fullScreenCorver(selectView)
        case .inquirySelectMutilStatus(let selectResult, let selectedItem):
            let selectView = IBSelectedMutilDataView.inquirySelectMutilStatus(result: selectResult, selectedItem: selectedItem ?? [])
            return .fullScreenCorver(selectView)
        }
    }
}
