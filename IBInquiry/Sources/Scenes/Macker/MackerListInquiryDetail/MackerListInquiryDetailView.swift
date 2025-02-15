//
//  MackerListInquiryDetailView.swift
//  IBInquiry
//
//  Created by Son phan on 11/2/25.
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

struct MackerListInquiryDetailView: View {
    
    @State var detailTransaction: TxnInquiryDetailResponseEntity?
    @State private var showInfo: Bool = false
    @State private var isShowApprove: Bool = false
    @State private var isShowReject: Bool = false
    @State var contentReject: String = ""
    @State private var isShowAuthen: Bool = false
    @State private var isShowApproveThuHoi: Bool = false
    @State var showDocumentExporter: Bool = false
    @State var validURLString: String = ""
    
    @Inject var transactionSigning: TransactionSigningNew?
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.themeCoordinator) private var themeCoordinator
    @Environment(\.alertCoordinator) private var alertCoordinator
    
    var typeTransaction: TransInquiryType = .single
    
    let id: String
    public var model: MackerDLIState
    public var handle: Handle<MackerDLIAction>?
    
    init(id: String, model: MackerDLIState, handle: Handle<MackerDLIAction>?, transType: TransInquiryType) {
        self.id = id
        self.model = model
        self.handle = handle
        self.typeTransaction = transType
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ScrollView(showsIndicators: false) {
                    //Thông tin tra soát
                    detailTransfer(detailTransaction: detailTransaction)
                    // Thông tin giao dịch gốc
                    inforBankAnswer(detailTransaction: detailTransaction)
                   //Thông tin giao dịch
                    inforGeneralTransferView(detailTransaction: detailTransaction)
                    
                    detailBulkTrans(detailTransaction: detailTransaction)
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
                .isLoading(model.isLoading)
                .padding(.horizontal, .spacing.spaceM)
                .padding(.top, .spacing.spaceXs)
                .backgroundColor(themeCoordinator.color.bgMainSecondary)
                .ibNavigationTitle(IBResourcesStrings.chiTietGiaoDich, disableBack: false, backgroudColor: themeCoordinator.color.bgMainSecondary) {
                    navigationControls()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .sheet(isPresented: $showDocumentExporter, content: {
                if let validURL = URL(string: validURLString) {
                    DocumentExporter(fileURL: validURL).ignoresSafeArea(.all)
                }
            })
            .onViewDidLoad(perform: {
                handle?(.detail(action: .request(items: id)))
            })
            .onChangeValue(of: model.detail, {
                if case let .success(result: value) = $0 {
                    detailTransaction = value
                }
            })
        }
    }
    
    @MainActor
    private func detailTransfer(detailTransaction: TxnInquiryDetailResponseEntity?) -> some View {
        VStack(alignment: .leading, spacing: .spacing.spaceXs) {
            HStack {
                IBResourcesAsset.headerSectionIcon.swiftUIImage.resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 24)
                Text(IBResourcesStrings.thongTinGiaoDich)
                    .styleTypography(.titleM)
                    .foregroundColor(themeCoordinator.color.contentMainPrimary)
                Spacer()
            }
            .padding([.leading, .trailing], .spacing.spaceM)
            .frame(height: .spacing.space5xl)
            TransactionDetailRow(title: IBResourcesStrings.maGiaoDichTraSoat, value: detailTransaction?.id ?? "")
            TransactionDetailRow(title: IBResourcesStrings.trangThai, value: TransactionInquiryStatus(rawValue: detailTransaction?.status ?? "")?.status ?? "", isStatus: true)
            TransactionDetailRow(title: IBResourcesStrings.ngayTaoTraSoat, value: detailTransaction?.createdDate ?? "")
            TransactionDetailRow(title: IBResourcesStrings.phiGiaoDich, value: String(describing: detailTransaction?.feeTotal))
            TransactionDetailRow(title: IBResourcesStrings.lyDoTraSoat, value: detailTransaction?.inquiryReason ?? "")
            TransactionDetailRow(title: IBResourcesStrings.noiDungTraSoat, value: detailTransaction?.inquiryDesc ?? "")
        }
        .background(themeCoordinator.color.bgMainTertiary)
        .cornerRadius(.radius.l)
        .padding(.bottom, .spacing.space2xs)
    }
    
    @MainActor
    private func inforBankAnswer(detailTransaction: TxnInquiryDetailResponseEntity?) -> some View {
        VStack(alignment: .leading, spacing: .spacing.spaceXs) {
            HStack {
                IBResourcesAsset.headerSectionIcon.swiftUIImage.resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 24)
                Text(IBResourcesStrings.thongTinBangKe)
                    .styleTypography(.titleM)
                    .foregroundColor(themeCoordinator.color.contentMainPrimary)
                Spacer()
            }
            .padding([.leading, .trailing], .spacing.spaceM)
            .frame(height: .spacing.space5xl)
            TransactionDetailRow(title: IBResourcesStrings.ketQuaTraSoat, value: detailTransaction?.inquiryResult ?? "")
            TransactionDetailRow(title: IBResourcesStrings.noiDungNganHangTraLoi, value: detailTransaction?.inquiryAnswer ?? "")
        }
        .background(themeCoordinator.color.bgMainTertiary)
        .cornerRadius(.radius.l)
        .padding(.bottom, .spacing.space2xs)
    }
    
    @MainActor
    private func inforGeneralTransferView(detailTransaction: TxnInquiryDetailResponseEntity?) -> some View {
        VStack(alignment: .leading, spacing: .spacing.spaceXs) {
            HStack {
                IBResourcesAsset.headerSectionIcon.swiftUIImage.resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 24)
                Text(IBResourcesStrings.thongTinBangKe)
                    .styleTypography(.titleM)
                    .foregroundColor(themeCoordinator.color.contentMainPrimary)
                Spacer()
                Button(
                    action: {
                        withAnimation {
                            showInfo.toggle()
                        }
                    },
                    label: {
                        if showInfo {
                            IBResourcesAsset.arrowTopOutline.swiftUIImage.resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        } else {
                            IBResourcesAsset.arrowBottomOutline.swiftUIImage.resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                )
                .frame(width: 32, height: 32)
            }
            .frame(height: 48)
            .padding([.leading, .trailing], .spacing.spaceM)
            
            if showInfo {
                TransactionDetailRow(title: IBResourcesStrings.soTienGiaoDich, value: String(detailTransaction?.amount ?? 0), isMoneyTransSum: true)
                TransactionDetailRow(title: IBResourcesStrings.soTaiKhoanChuyen, value: detailTransaction?.debitAccNo ?? "")
                TransactionDetailRow(title: IBResourcesStrings.tenNguoiChuyen, value: detailTransaction?.debitAccName ?? "")
                TransactionDetailRow(title: IBResourcesStrings.nganHangHuong, value: detailTransaction?.benBankNameShort ?? "")
                TransactionDetailRow(title: IBResourcesStrings.soTaiKhoanHuong, value: detailTransaction?.benAccNo ?? "")
                TransactionDetailRow(title: IBResourcesStrings.tenNguoiHuong, value: detailTransaction?.benName ?? "")
                TransactionDetailRow(title: IBResourcesStrings.maGiaoDich, value: detailTransaction?.orgTxnId ?? "")
                TransactionDetailRow(title: IBResourcesStrings.loaiGiaoDich, value: detailTransaction?.txnType ?? "")
                TransactionDetailRow(title: IBResourcesStrings.trangThai, value: detailTransaction?.txnStatus ?? "")
                TransactionDetailRow(title: IBResourcesStrings.ngayHieuLuc, value: detailTransaction?.effDate ?? "")
                TransactionDetailRow(title: IBResourcesStrings.noiDungGiaoDich, value: detailTransaction?.remark ?? "")
            }
        }
        .background(themeCoordinator.color.bgMainTertiary)
        .cornerRadius(.radius.l)
        .padding(.bottom, .spacing.space2xs)
        .id("last")
    }
    
    @MainActor
    private func detailBulkTrans(detailTransaction: TxnInquiryDetailResponseEntity?) -> some View {
        VStack(alignment: .leading, spacing: .spacing.spaceXs) {
            HStack {
                ZStack {
                    Circle()
                        .fill(themeCoordinator.color.bgMainPrimary)
                        .frame(width: 40, height: 40)
                    IBResourcesAsset.truyVanBieuPhiOutline.swiftUIImage.resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }.padding(.trailing, .spacing.spaceXs)
                VStack(alignment: .leading, spacing: .spacing.spaceXs) {
                    Text(IBResourcesStrings.chiTietBangKe)
                        .styleTypography(.titleS)
                        .foregroundColor(themeCoordinator.color.contentMainPrimary)
                    Text(IBResourcesStrings.xemChiTietBangKe)
                        .styleTypography(.bodyM)
                        .foregroundColor(themeCoordinator.color.contentMainSecondary)
                }
                Spacer()
                Button(
                    action: {
//                        navigation.execute(.navigate(IBBulkRoute.childTransactionList(id: detailTransaction?.id ?? ""), animated: true))
                    },
                    label: {
                        IBResourcesAsset.arrowRightOutline.swiftUIImage.resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                )
                .frame(width: 32, height: 32)
            }
            .padding(.spacing.spaceM)
        }
        .background(themeCoordinator.color.bgMainTertiary)
        .cornerRadius(.radius.l)
        .padding(.bottom, .spacing.spaceM)
        .onTapGesture {
//            navigation.execute(.navigate(IBBulkRoute.childTransactionList(id: detailTransaction?.id ?? ""), animated: true))
        }
    }
    
    @MainActor
    private func navigationControls() -> some View {
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
//                        if let url = ShareDeeplinks.historyImpactTransaction(
//                            txnCode: detailTransaction?.txnCode ?? "",
//                            txnId: detailTransaction?.id ?? ""
//                        ) {
//                            navigation.execute(.openDeeplink(url, continuous: true))
//                        }
                    },
                    label: {
                        IBResourcesAsset.history.swiftUIImage.resizable().renderingMode(.template)
                            .foregroundColor(themeCoordinator.color.contentMainSecondary).frame(width: 20, height: 20)
                    }
                )
                .frame(width: 32, height: 32)
            }
        }
    }
    
    private func showAlertMessError(message: String, confirm: @escaping () -> Void) {
        alertCoordinator.show(type: .error,
                              title: IBResourcesStrings.loi,
                              message: message,
                              confirmTitle: IBResourcesStrings.dong,
                              hideCancelButton: true, onConfirm: confirm
        )
    }
}
