import Foundation
import NavigationCoordinator
import IBFoundation
import IBNetworkInterface
import IBNetwork
import IBAuth
import IBFeatureCommon
import IBSmartOTP
import IBInquiry

public struct IBInquiryActionRoute: AppAction {
    public func root() -> Routable {
        return IBInquiryRoute.main
    }
}

public enum IBInquiryActionRouteRoot {
    case root
}

public struct SmartOtpRouteImplements: SmartOtpRouteAction {
    public func root() -> Routable {
        return IBInquiryActionRouteRoot.root
    }
}

extension IBInquiryActionRouteRoot: Routable {
    public var type: RouteType {
        return IBInquiryRoute.main.type
    }
}

extension IBankApp {
    func injectResolving(navigation: NavigationAction) {
        
        DIContainer.standard.register(type: AppAction.self) { _ in
            return IBInquiryActionRoute()
        }
        
        DIContainer.standard.register(type: HeaderDefine.self) { _ in
            return IBankAppHeaderDefine()
        }
  
        DIContainer.standard.register(type: AuthenNetworkDefine.self) { _ in
            return AuthenNetworkDefine.shared
        }
        
        DIContainer.standard.register(type: AuthenRefreshService.self) { _ in
            AuthenRefreshService(navigationAction: navigation)
        }
        
        DIContainer.standard.register(type: Network.self, name: "authen") { _ in
            IBNetwork(baseURL: AuthenNetworkDefine.shared.baseUrl, requestBehaviors: [BehaviorIBInquiry()])
        }
        
        DIContainer.standard.register(type: Network.self) { _ in
            let ibNetwork = IBNetwork(baseURL: DefaultIBInquiryNetworkDefine.shared.baseUrl, requestBehaviors: [BehaviorIBInquiry()])
            registerNetwork(ibNetwork: ibNetwork)
            return ibNetwork
        }

        DIContainer.standard.register(type: IBInquiryEnviromentProtocol.self) { _ in
            IBInquiryEnviroment()
        }
        
        DIContainer.standard.register(type: LoginEnviroment.self) { _ in
            LoginRealEnviroment()
        }
        
        DIContainer.standard.register(type: SmartOtpEnviroment.self) { _ in
            SmartOtpRealEnviroment()
        }

        DIContainer.standard.register(type: SmartOtpRouteAction.self) { _ in
            return SmartOtpRouteImplements()
        }

        DIContainer.standard.register(type: TransactionSigning.self) { _ in
            return SmartOtpSigning()
        }

        DIContainer.standard.register(type: TransactionSigningNew.self) { _ in
            return SmartOtpSigning()
        }

    }
    
    func registerNetwork(ibNetwork: IBNetwork) {
        print("registerSession \(String(describing: ibNetwork))")
        let env = DIContainer.standard.resolve(type: AuthenRefreshService.self)
        env?.registerNetwork(network: ibNetwork)
    }
}
