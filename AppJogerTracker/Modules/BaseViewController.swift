import UIKit
import RxCocoa
import SnapKit
import RxSwift

public class BaseViewController<View: UIView, ViewModel: ViewModelType>: UIViewController, Alertable {
        
   public lazy var contentView = view as! View
   public lazy var disposableBag: DisposeBag! = .init()
   public var viewModel: ViewModel
    
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
   public override func loadView() {
        view = View()
        navigationController?.navigationItem.hidesBackButton = true
    }
   public override func viewDidLoad() {
        super.viewDidLoad()

    }
}
