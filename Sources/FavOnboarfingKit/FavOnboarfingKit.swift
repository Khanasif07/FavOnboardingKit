// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit
public protocol FavOnboarfingKitDelegate: NSObject{
    func nextButtonDidTap(atIndex index: Int)
    func getStartedButtonDidTap()
}
public class FavOnboarfingKit{
    
    public weak var delegate: FavOnboarfingKitDelegate?
    private let slides : [Slide]
    private let tintColor: UIColor
    private var rootVC: UIViewController?
    
    public init(slides: [Slide], tintColor: UIColor){
        self.slides = slides
        self.tintColor = tintColor
    }
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let controller = OnboardingViewController(slides: self.slides, tintColor: self.tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.nextButtonDidTap = { [weak self] index in
            self?.delegate?.nextButtonDidTap(atIndex: index)
        }
        
        controller.getStartedButtonDidTap = { [weak self]  in
            self?.delegate?.getStartedButtonDidTap()
        }
        return controller
    }()
    
    
    
    public func launchOnboarding(rootVC: UIViewController){
        self.rootVC = rootVC
        rootVC.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding(){
        onboardingViewController.stopAnimation()
        if ((rootVC?.presentedViewController as? OnboardingViewController) != nil){
            DispatchQueue.main.async {
                self.onboardingViewController.dismiss(animated: true, completion: nil)
            }
          
        }
    }
}
