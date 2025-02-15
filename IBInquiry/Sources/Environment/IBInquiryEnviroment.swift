import Foundation
import IBFoundation
import IBNetworkInterface
import IBCommon
import CasePaths
import KeychainAccess
import SwiftUI
import IBFeatureCommon

public protocol IBInquiryEnviromentProtocol {
    func getListInquiryListMaker(model: MackerListInquiryFilterModel, pageSize: Int, pageNum: Int) async -> Result<[TxnInquiryResponseEntity], IBError>
    func getCategoriesByType(request: CategoryRequestEntity) async -> Result<[CategoryResponseEntity], IBError>
    func getListInquiryListChecker(model: CheckerListInquiryFilterModel, pageSize: Int, pageNum: Int) async -> Result<[TxnInquiryResponseEntity], IBError>
    func getPrintInquiryMaker(ids: [String]) async -> Result<TxnPrintResponseEntity, IBError>
    func getReportInquiryMaker(entity: TxnInquiryListRequestEntity) async -> Result<TxnPrintResponseEntity, IBError>
    func createFundTransferInquiry(id: String) async -> Result<CreateFundTransferInquiryResponseEntity, IBError>
    func getDetailInquiryChecker(id: String) async -> Result<TxnInquiryDetailResponseEntity, IBError>
    func getDetailInquiryBulkChecker(id: String) async -> Result<TxnInquiryBulkDetailResponseEntity, IBError>
    func getDetailInquiryBulkChildChecker(id: String) async -> Result<TxnInquiryBulkChildDetailResponseEntity, IBError>
    func approveInquiry(txnIds: [String]) async -> Result<InitTransactionResObjectEntity, IBError>
    func approveConfirmInquiry(transKey: String, confirmValue: String) async -> Result<ConfirmTransRecallResEntity, IBError>
    func rejectPaymentInquiry(txnIds: [String], rejectReason: String?) async -> Result<ConfirmTransRecallResEntity, IBError>
    func getDetailInquiryMaker(transactionId: String) async -> Result<TxnInquiryDetailResponseEntity, IBError>
    func getListInquiryListTransfer(model: MackerListOriginalTransFilterModel, pageSize: Int, pageNum: Int) async -> Result<DataListTxnInquiryListTransferResponseEntity, IBError>
    func getListInquiryListBulk(model: MackerListInquiryFilterModel, page: PageEntity) async -> Result<DataListTxnInquiryListBulkResponseEntity, IBError>
}

public struct IBInquiryEnviroment: IBInquiryEnviromentProtocol {
    
    @Inject
    var network: Network?
    
    public init() {}
    
    public func updateTrans() async {
        await MainActor.run {
            NotificationCenter.default.post(name: .updateTrans, object: nil)
        }
    }
    
    public func getListInquiryListMaker(model: MackerListInquiryFilterModel, pageSize: Int, pageNum: Int) async -> Result<[TxnInquiryResponseEntity], IBError> {
        var dtoModel = model.toTxnInquiryListRequestDto()
        let page = Page(pageSize: pageSize, pageNum: pageNum, getTotal: true)
        dtoModel.page = page
        let result: Result<ResultListTxnInquiryResponseDto, IBError> = await (network?.getData(request: InquiryAPI.getListInquiryListMaker(txnInquiryListRequestDto: dtoModel))).toResultValue()
        return result.flatMap {
            if let items = $0.data?.items {
                let itemsEntity = items.map { $0.toEntity() }
                return .success(itemsEntity)
            }
            return .failure(.dataError)
        }
    }
    
    public func getCategoriesByType(request: CategoryRequestEntity) async -> Result<[CategoryResponseEntity], IBError> {
        let categoryRequest = request.toCategoryRequestDto()
        let result: Result<ResultListCategoryResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getCategoriesByType(categoryRequestDto: categoryRequest))).toResultValue()
        return result.flatMap {
            if let items = $0.data?.items {
                let itemsEntity = items.map { $0.toEntity() }
                return .success(itemsEntity)
            }
            return .failure(.dataError)
        }
    }
    
    public func getListInquiryListChecker(model: CheckerListInquiryFilterModel, pageSize: Int, pageNum: Int) async -> Result<[TxnInquiryResponseEntity], IBError> {
        var dtoModel = model.toInquiryCheckerRequestDto()
        let page = Page(pageSize: pageSize, pageNum: pageNum, getTotal: true)
        dtoModel.page = page
        let result: Result<ResultListTxnInquiryResponseDto, IBError> = (await network?.getData(request: InquiryAPI.getListInquiryListChecker(txnInquiryListRequestDto: dtoModel))).toResultValue()
        return result.flatMap {
            if let items = $0.data?.items {
                let itemsEntity = items.map { $0.toEntity() }
                return .success(itemsEntity)
            }
            return .failure(.dataError)
        }
    }
            
    public func getDetailInquiryMaker(transactionId: String) async -> Result<TxnInquiryDetailResponseEntity, IBError> {
        let request = TxnInquiryDetailRequestDto(id: transactionId)
        
        let result: Result<ResultTxnInquiryDetailResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getDetailInquiryMaker(txnInquiryDetailRequestDto: request))).toResultValue()
        return result.flatMap {
            if let item = $0.data {
                return .success(item.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func getPrintInquiryMaker(ids: [String]) async -> Result<TxnPrintResponseEntity, IBError> {
        let requestDto = TxnPrintRequestDto(id: ids)
        let result: Result<ResultTxnPrintResponseDto, IBError> = (await network?.getData(request: InquiryAPI.getPrintInquiryMaker(txnPrintRequestDto: requestDto))).toResultValue()
        return result.flatMap {
            if let item = $0.data {
                return .success(item.toEntity())
            }
            
            return .failure(.dataError)
        }
    }
    
    public func getReportInquiryMaker(entity: TxnInquiryListRequestEntity) async -> Result<TxnPrintResponseEntity, IBError> {
        var requestDto = entity.toDtoModel()
        let page = Page(pageSize: 20, pageNum: 1)
        requestDto.page = page
        let result: Result<ResultTxnPrintResponseDto, IBError> = (await network?.getData(request: InquiryAPI.getReportInquiryMaker(txnInquiryListRequestDto: requestDto))).toResultValue()
        return result.flatMap {
            if let item = $0.data {
                return .success(item.toEntity())
            }
            
            return .failure(.dataError)
        }
    }
    
    public func createFundTransferInquiry(id: String) async -> Result<CreateFundTransferInquiryResponseEntity, IBError> {
        let dtoModel = CreateTransferInquiryRequest(id: id)
        
        let result: Result<ResultCreateFundTransferInquiryResponse, IBError> = (await network?.getData(request: InquiryAPI.createFundTransferInquiry(createTransferInquiryRequest: dtoModel))).toResultValue()
        
        return result.flatMap {
            if let item = $0.data {
                return .success(item.toEntity())
            }
            
            return .failure(.dataError)
        }
    }
    
    public func getDetailInquiryChecker(id: String) async -> Result<TxnInquiryDetailResponseEntity, IBError> {
        let result: Result<ResultTxnInquiryDetailResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getDetailInquiryChecker(txnInquiryDetailRequestDto: TxnInquiryDetailRequestDto(id: id)))).toResultValue()
        return result.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func getDetailInquiryBulkChecker(id: String) async -> Result<TxnInquiryBulkDetailResponseEntity, IBError> {
        let result: Result<ResultTxnInquiryBulkDetailResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getDetailInquiryBulkChecker(txnInquiryDetailRequestDto: TxnInquiryDetailRequestDto(id: id)))).toResultValue()
        return result.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func getDetailInquiryBulkChildChecker(id: String) async -> Result<TxnInquiryBulkChildDetailResponseEntity, IBError> {
        let result: Result<ResultTxnInquiryBulkChildDetailResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getDetailInquiryBulkChildChecker(txnInquiryDetailRequestDto: TxnInquiryDetailRequestDto(id: id)))).toResultValue()
        return result.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func approveInquiry(txnIds: [String]) async -> Result<InitTransactionResObjectEntity, IBError> {
        let resultDto: Result<ResultInitTransactionResObject, IBError> =
        (await network?.getData(request: InquiryAPI.approveInquiry(approveInquiryRequestDto: ApproveInquiryRequestDto(txnIds: txnIds)))).toResultValue()
        return resultDto.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func approveConfirmInquiry(transKey: String, confirmValue: String) async -> Result<ConfirmTransRecallResEntity, IBError> {
        let resultDto: Result<ResultConfirmTransRecallResDto, IBError> =
        (await network?.getData(request: InquiryAPI.approveConfirmInquiry(initTransConfirmDto: InitTransConfirmDto(transKey: transKey, confirmValue: confirmValue)))).toResultValue()
        return resultDto.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func rejectPaymentInquiry(txnIds: [String], rejectReason: String?) async -> Result<ConfirmTransRecallResEntity, IBError> {
        let resultDto: Result<ResultConfirmTransRecallResDto, IBError> =
        (await network?.getData(request: InquiryAPI.rejectPaymentInquiry(rejectTransactionDTO: RejectTransactionDTO(txnIds: txnIds, rejectReason: rejectReason)))).toResultValue()
        return resultDto.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
    
    public func getListInquiryListTransfer(model: MackerListOriginalTransFilterModel, pageSize: Int, pageNum: Int) async -> Result<DataListTxnInquiryListTransferResponseEntity, IBError> {
        var dtoModel = model.toMackerListOriginalTransRequestDto()
        let page = Page(pageSize: pageSize, pageNum: pageNum, getTotal: true)
        dtoModel.page = page
        let result: Result<ResultListTxnInquiryListTransferResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getListInquiryListTransfer(txnInquiryListTransferRequestDto: dtoModel))).toResultValue()
        
        return result.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
            
    public func getListInquiryListBulk(model: MackerListInquiryFilterModel, page: PageEntity) async -> Result<DataListTxnInquiryListBulkResponseEntity, IBError> {
        var dtoModel = TxnInquiryListTransferRequestDto()
        dtoModel.page = page.toDtoModel()
        let resultDto: Result<ResultListTxnInquiryListBulkResponseDto, IBError> =
        (await network?.getData(request: InquiryAPI.getListInquiryListBulk(txnInquiryListTransferRequestDto: dtoModel))).toResultValue()
        return resultDto.flatMap {
            if let items = $0.data {
                return .success(items.toEntity())
            }
            return .failure(.dataError)
        }
    }
}

extension Notification.Name {
    public static let updateTrans = Notification.Name("updateTrans")
}
