import Swinject
import Foundation

class AppAssembly {
    
    var container: Container
    
    
    init(container: Container) {
        self.container = container
        appDependencies()
        
    }
    
    private func appDependencies() {
        
        container.register(AppPreferences.self) { _ in
            AppPreferences.init()
        }.inObjectScope(.container)
        
        container.register(NetworkLayer.self) {
            NetworkLayer(preferences: $0.resolve(AppPreferences.self))
        }.inObjectScope(.container)
        
        
        container.register(AuthServiceProtocol.self) {
            AuthenticationService(authApi: $0.resolve(NetworkLayer.self), preferences: $0.resolve(AppPreferences.self))
        }.inObjectScope(.container)
        
        container.register(JogsProviderProtocol.self) {
            JogsProvider(network: $0.resolve(NetworkLayer.self))
        }.inObjectScope(.container)
        
        container.register(JogsNetworkManagerProtocol.self) {
            NetworkLayer(preferences: $0.resolve(AppPreferences.self))
        }.inObjectScope(.container)
        
        container.register(JogsProvider.self) {
            JogsProvider(network: $0.resolve(JogsNetworkManagerProtocol.self))
        }.inObjectScope(.container)
        
        container.register(Jog.self) { _ in
            Jog.init()
        }.inObjectScope(.container)
        
        container.register(JogsViewModel.self) {
            JogsViewModel(jogsProvider: $0.resolve(JogsProviderProtocol.self))
        }.inObjectScope(.container)
        
        container.register(JogDetailViewModelImpl.self) {
            JogDetailViewModelImpl(jogProvider: $0.resolve(JogsProvider.self), jog: $0.resolve(Jog.self)!)
        }
        
        container.register(JogsEditingViewModel.self) {
            JogsEditingViewModel(jogProvider: $0.resolve(JogsProviderProtocol.self), jog: $0.resolve(Jog.self)!)
        }
        
        container.register(JogAddingViewModel.self) {
            JogAddingViewModel(jogProvider: $0.resolve(JogsProviderProtocol.self), jog: $0.resolve(Jog.self)!)
        }
        
        container.register(JogsProviderProtocol.self) {
            JogsProvider(network: $0.resolve(NetworkLayer.self))
        }.inObjectScope(.container)
        
        container.register(LoginViewModel.self) {
            LoginViewModel(service: $0.resolve(AuthServiceProtocol.self))
        }.inObjectScope(.container)
        
    }
    
    
}

