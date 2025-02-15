import UIKit
import NavigationCoordinator
import IBFoundation
import IBNetworkInterface
import IBResources
import IBAuth
import IBAuthMock
import CustomDump
import NavigationTransitions
import IBFeatureCommon
import IQKeyboardManagerSwift
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        #endif
        Bundle(path: injectionBundlePath)?.load()
        #endif

        return true
    }
}

@main
struct IBankApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var appCoordinator: Coordinator = .init()
    var navigation: NavigationAction = NavigationAction.empty
    
    init() {
        navigation = NavigationAction(
            canBack: appCoordinator.canBack,
            action: appCoordinator.execute(type:),
            interactivity: appCoordinator.setInteractivity(_:)
        )
        
        injectResolving(navigation: navigation)
        navigation.execute(.navigate(AuthRoute.login))
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                SetEnviromentView(appCoordinator: appCoordinator)
                CoordinatorView(coordinator: appCoordinator)
                    .ignoresSafeArea()
                    .onOpenURL(perform: { url in
                        let needLogin = false
                        if appCoordinator.requireAuth(url: url) {
                            appCoordinator.execute(AuthRoute.loginWithLink(url.absoluteString))
                        } else {
                            appCoordinator.open(url: url)
                        }
                    })
            }
            
            .sheetCoordinator()
            .alertCoordinator(appCoordinator)
            .snackBarCoordinator()
            .navigationCoordinator(navigation)
            .environment(\.autoKeyboard, AutoKeyboardAction(enable: { value in
                IQKeyboardManager.shared.enableAutoToolbar = value
                IQKeyboardManager.shared.enable = value
            }))
            .overlayAllView()
            .onAppear {
                appCoordinator.setNavigationTransition(.slide, interactivity: .edgePan)
            }
            
        }
    }
}
