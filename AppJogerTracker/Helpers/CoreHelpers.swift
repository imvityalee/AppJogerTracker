import Foundation

public func dispatchAsyncAfter(time: Double = 0.1,  action: @escaping () -> Void)  {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        action()
    }
}

