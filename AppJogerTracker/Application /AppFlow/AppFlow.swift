import RxFlow
import Swinject
import UIKit

class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    var container: Container
    var appAssembly: AppAssembly
    
    init(assembly: AppAssembly, container: Container) {
        self.container = container
        appAssembly = .init(container: container)
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.isHidden = true
        return viewController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else {
            return FlowContributors.none
        }
        switch step {
        case .login:
            return navigateToLogin()
        case .jogs:
            return navigateToJogs()
        case .jogsDetail(let jog):
            return navigateToJogsDetails(jog: jog)
        case .addJog:
            return navigateToAddJog()
        case .menu:
            return navigateToMenu()

        case .info:
            return navigateToInfo()
        case .close:
            rootViewController.dismiss(animated: true, completion: nil)
            return .none
       
        }
    }
    
    private func navigateToLogin() -> FlowContributors {
        
        let service = appAssembly.container.resolve(AuthServiceProtocol.self)
        
        let viewModel = LoginViewModel.init(service: service)
        let viewController = LoginViewController(viewModel: viewModel)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    private func navigateToJogs() -> FlowContributors {
        let service = appAssembly.container.resolve(JogsProviderProtocol.self)
        let viewModel = JogsViewModel.init(jogsProvider: service)
        let viewController = JogsViewController.init(viewModel: viewModel)
        
        if self.rootViewController.presentedViewController is MenuController {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                self.rootViewController.dismiss(animated: true, completion: nil)
            }
        } else if self.rootViewController.presentedViewController is JogDetailViewController {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in 
                guard let self = self else { return }
                self.rootViewController.dismiss(animated: true, completion: nil)
            }
        
        }
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    private func navigateToJogsDetails(jog: Jog) -> FlowContributors {
        let service = appAssembly.container.resolve(JogsProviderProtocol.self)
        let viewModel = JogsEditingViewModel.init(jogProvider: service, jog: jog)
        let viewController = JogDetailViewController(viewModel: viewModel)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .currentContext
        
        self.rootViewController.present(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    private func navigateToAddJog() -> FlowContributors {
        let service = appAssembly.container.resolve(JogsProviderProtocol.self)
        let viewModel = JogAddingViewModel.init(jogProvider: service, jog: .init())
        let viewController = JogDetailViewController(viewModel: viewModel)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .currentContext
        
        self.rootViewController.present(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    private func navigateToMenu() -> FlowContributors  {
        let viewModel = MenuViewModel.init()
        let viewController = MenuController(viewModel: viewModel)
        
        if self.rootViewController.presentedViewController is JogDetailViewController {
            self.rootViewController.dismiss(animated: true, completion: nil)
        }
        
        self.rootViewController.present(viewController, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    private func navigateToInfo() -> FlowContributors  {
        let viewModel = JogInfoViewModel.init()
        let viewController = JogInfoViewController(viewModel: viewModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.rootViewController.dismiss(animated: true, completion: nil)
        }
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
}
