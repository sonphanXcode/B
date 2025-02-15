//
//  CheckerDetailInquiryView.swift
//  IBInquiry
//
//  Created by tran dinh quy on 11/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources
import Foundation
import IBFoundation
import IBViewComponents
import IBNetworkInterface
import IBCommon
import IBFeatureCommon

struct CheckerDetailInquiryView: View {
    
    @State var detailTransaction: CheckerDetailInquiryModel?
    @State private var showInfo: Bool = false
    @State private var isShowApprove: Bool = false
    @State private var isShowReject: Bool = false
    @State var contentReject: String = ""
    
    @Inject var transactionSigning: TransactionSigningNew?
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.themeCoordinator) private var themeCoordinator
    @Environment(\.alertCoordinator) private var alertCoordinator
    
    let transactionId: String
    let type: TransInquiryType
    public var model: CheckerDetailInquiryState
    public var handle: Handle<CheckerDetailInquiryAction>?
    
    init(transactionId: String,
         type: TransInquiryType,
         model: CheckerDetailInquiryState,
         handle: Handle<CheckerDetailInquiryAction>?
    ) {
        self.model = model
        self.transactionId = transactionId
        self.type = type
        self.handle = handle
    }
    
    var body: some View {
        ScrollViewReader {proxy in
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        // Transaction Details
                        transDetail(detailTransaction: detailTransaction)
                        
                        // General Information
                        generalInformation(detailTransaction: detailTransaction)
                        
                    }
                    .padding([.leading, .trailing], .spacing.spaceM)
                }
                .onViewDidLoad {
                    handle?(.detail(action: .request(items: transactionId)))
                }
                .onChange(of: showInfo) { value in
                    if value {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                proxy.scrollTo("last", anchor: .bottom)
                            }
                        }
                    }
                }
                .onChangeValue(of: model.detail) {
                    if case let .success(result: value) = $0 {
                        detailTransaction = value
                    }
                }
                .onChangeValue(of: model.errorMessage ?? "", {
                    showAlertMessError(message: $0, confirm: { refreshList() })
                })
                .onChangeValue(of: model.approved) {
                    if let value = $0 {
                        if case .submitSuccess = value.status {
                            if let signing = value.signingInfo {
                                if let route = transactionSigning?.verify(signInfo: signing, result: { result in
                                    if case let .optCode(otp) = result {
                                        handle?(.approved(action: .signing(otp: otp)))
                                    }
                                }) {
                                    navigation.execute(.navigate(route, animated: true))
                                }
                            }
                        }

                        if case .signingSuccess = value.status {
                            if case .signingSuccess = value.status {
                                refreshList()
                                let data = ConfirmTransRecallResEntity(from: value.signingResult)
                            }
                        }
                    }
                }
                .onChangeValue(of: model.reject, {
                    if case let .success(result: value) = $0 {}
                })
                .isLoading(model.isLoading)
                .backgroundColor(themeCoordinator.color.bgMainSecondary)
                .ibNavigationTitle(IBResourcesStrings.chiTietGiaoDich) {
                    navigationControls
                }
                
                HStack(spacing: .spacing.spaceM) {
                    IBButton(
                        action: {
                            isShowReject.toggle()
                        },
                        title: IBResourcesStrings.tuChoi,
                        style: .secondaryDestructive,
                        size: .large
                    )
                    IBButton(
                        action: {
                            isShowApprove.toggle()
                        },
                        title: IBResourcesStrings.duyet,
                        size: .large
                    )
                }.padding(.horizontal, .spacing.spaceM)
                
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .ibModalConfirm(
                isPresented: $isShowApprove,
                type: .question,
                title: IBResourcesStrings.xacNhanPheDuyet,
                message: IBResourcesStrings.quyKhachCoChacChanPheDuyetGiaoDichKhong,
                onConfirm: {
                    handleSubmit()
                })
            .ibModalWithInput(
                isPresented: $isShowReject,
                text: $contentReject,
                title: IBResourcesStrings.tuChoiGiaoDich,
                placeholder: IBResourcesStrings.lyDoTuChoi,
                onConfirm: {
                    handleReject(contentReject)
                })
        }
    }
    
    @MainActor
    func transDetail(detailTransaction: CheckerDetailInquiryModel?) -> some View {
        VStack(alignment: .leading, spacing: .spacing.spaceXs) {
            HStack {
                IBResourcesAsset.headerSectionIcon.swiftUIImage.resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 24)
                Text(IBResourcesStrings.thongTinTraSoat)
                    .styleTypography(.titleM)
                    .foregroundColor(themeCoordinator.color.contentMainPrimary)
            }
            .frame(height: 48)
            .padding([.leading, .trailing], .spacing.spaceM)
            CheckerInquiryDetailRow(title: IBResourcesStrings.maGiaoDichTraSoat, value: detailTransaction?.id ?? "", isMoneyTransSum: true).frame(height: 40)
            CheckerInquiryDetailRow(title: IBResourcesStrings.trangThai, value: detailTransaction?.status ?? "", isStatus: true)
            CheckerInquiryDetailRow(title: IBResourcesStrings.ngayTaoTraSoat, value: detailTransaction?.createdDate ?? "")
            CheckerInquiryDetailRow(title: IBResourcesStrings.phiGiaoDich, value: "\(detailTransaction?.feeTotal?.formattedCurrency(detailTransaction?.ccy) ?? "") \(detailTransaction?.ccy ?? "")")
            CheckerInquiryDetailRow(title: IBResourcesStrings.lyDoTraSoat, value: InquiryReasonCodeType(rawValue: detailTransaction?.inquiryReason ?? "")?.reasonType ?? "")
            CheckerInquiryDetailRow(title: IBResourcesStrings.noiDungTraSoat, value: detailTransaction?.inquiryDesc ?? "")
        }
        .background(themeCoordinator.color.bgMainTertiary)
        .cornerRadius(.radius.l)
        
    }
    
    @MainActor
    func generalInformation(detailTransaction: CheckerDetailInquiryModel?) -> some View {
        VStack(alignment: .leading, spacing: .spacing.spaceXs) {
            HStack {
                IBResourcesAsset.headerSectionIcon.swiftUIImage.resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 24)
                Text(IBResourcesStrings.thongTinGiaoDichGoc)
                    .styleTypography(.titleM)
                Spacer()
                Button(
                    action: {
                        withAnimation {
                            showInfo.toggle()
                        }
                    },
                    label: {
                        if showInfo {
                            IBResourcesAsset.arrowTopOutline.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        } else {
                            IBResourcesAsset.arrowBottomOutline.swiftUIImage.resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        
                    }
                )
                .frame(width: 30, height: 30)
            }
            .frame(height: 48)
            .padding([.leading, .trailing], .spacing.spaceM)
            
            if showInfo {
                if type == .salary || type == .bulk {
                    CheckerInquiryDetailRow(title: IBResourcesStrings.tongTien, value: "\(detailTransaction?.amount?.formattedCurrency(detailTransaction?.ccy) ?? "") \(detailTransaction?.ccy ?? "")", isMoneyTransSum: true)
                    CheckerInquiryDetailRow(title: IBResourcesStrings.tongGiaoDich, value: IBResourcesStrings.dGiaoDich(Int(detailTransaction?.totalRow ?? 0)), isTransaction: true)
                    CheckerInquiryDetailRow(title: IBResourcesStrings.taiKhoanTrichNo, value: detailTransaction?.debitAccNo ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.tenTaiKhoan, value: detailTransaction?.debitAccName ?? "")
                    CheckerInquiryDetailRow(title: type == .bulk ? IBResourcesStrings.maBangKe : IBResourcesStrings.maBangLuong, value: detailTransaction?.orgTxnId ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.loaiGiaoDich, value: TransInquiryType(rawValue: detailTransaction?.txnType ?? "")?.type ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.trangThai, value: detailTransaction?.status ?? "", isStatus: true)
                    CheckerInquiryDetailRow(title: IBResourcesStrings.ngayHieuLuc, value: detailTransaction?.effDate ?? "")
                    if type == .salary {
                        CheckerInquiryDetailRow(title: IBResourcesStrings.noiDungGiaoDich, value: detailTransaction?.remark ?? "")
                    }
                } else {
                    CheckerInquiryDetailRow(title: IBResourcesStrings.soTienGiaoDich, value: "\(detailTransaction?.amount?.formattedCurrency(detailTransaction?.ccy) ?? "") \(detailTransaction?.ccy ?? "")", isMoneyTransSum: true)
                    CheckerInquiryDetailRow(title: IBResourcesStrings.soTaiKhoanChuyen, value: detailTransaction?.debitAccNo ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.tenNguoiChuyen, value: detailTransaction?.debitAccName ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.nganHangHuong, value: detailTransaction?.benBankNameShort ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.soTaiKhoanHuong, value: detailTransaction?.benAccNo ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.tenNguoiHuong, value: detailTransaction?.benName ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.maGiaoDich, value: detailTransaction?.orgTxnId ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.loaiGiaoDich, value: TransInquiryType(rawValue: detailTransaction?.txnType ?? "")?.type ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.trangThai, value: detailTransaction?.txnStatus ?? "", isStatus: true)
                    CheckerInquiryDetailRow(title: IBResourcesStrings.ngayHieuLuc, value: detailTransaction?.effDate ?? "")
                    CheckerInquiryDetailRow(title: IBResourcesStrings.noiDungGiaoDich, value: detailTransaction?.remark ?? "")
                    if type != .single {
                        CheckerInquiryDetailRow(title: type == .bulkChild ? IBResourcesStrings.maBangKe : IBResourcesStrings.maBangLuong, value: detailTransaction?.bulkId ?? ""
                        )
                    }
                }
            }
        }
        .background(themeCoordinator.color.bgMainTertiary)
        .cornerRadius(.radius.l)
        .padding(.bottom, .spacing.spaceXs)
        .id("last")
    }
    
    @MainActor
    private var navigationControls: some View {
        Group {
            HStack {
                Button(
                    action: {
                        navigation.execute(.popToRoot(animated: true))
                    },
                    label: {
                        IBResourcesAsset.homeOutline.swiftUIImage.resizable().renderingMode(.template)
                            .foregroundColor(themeCoordinator.color.contentMainSecondary).frame(width: 20, height: 20)
                    }
                )
                .frame(width: 32, height: 32)
                
                Button(
                    action: {
                        /// Last item action
                    },
                    label: {
                        IBResourcesAsset.history.swiftUIImage.resizable().renderingMode(.template)
                            .foregroundColor(themeCoordinator.color.contentMainSecondary).frame(width: 20, height: 20)
                    }
                )
                .frame(width: 32, height: 32)
                Spacer()
            }
        }
    }
    
    private func showAlertMessError(message: String, confirm: @escaping () -> Void) {
        alertCoordinator.show(
            type: .error,
            title: IBResourcesStrings.loi,
            message: message,
            confirmTitle: IBResourcesStrings.dong,
            hideCancelButton: true,
            onConfirm: confirm
        )
    }
}
