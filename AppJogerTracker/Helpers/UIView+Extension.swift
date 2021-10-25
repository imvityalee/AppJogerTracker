import UIKit

public extension UIView {
    @discardableResult
    func addSubViews(_ views: [UIView?]) -> UIView {
        views.forEach { (view) in
            if let view = view {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
            }
        }
        return self
    }

}
