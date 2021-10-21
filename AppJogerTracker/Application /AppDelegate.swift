import UIKit
import RxFlow
import Swinject
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: FlowCoordinator = .init()
    var appAssembly: AppAssembly!
    var container: Container = .init()
  
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFlow()
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    func configureFlow() {
        
        appAssembly = AppAssembly(container: container)
        let mainFlow: AppFlow = AppFlow(assembly: appAssembly, container: container)

        let appFlowStepper = mainFlow.appAssembly.container.resolve(LoginViewModel.self)!
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        
        Flows.whenReady(flow1: mainFlow){  (root) in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        coordinator.coordinate(flow: mainFlow, with: appFlowStepper)
    }
    
}

