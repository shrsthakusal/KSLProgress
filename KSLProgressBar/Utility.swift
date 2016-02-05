import Foundation
import QuartzCore

extension CALayer {
    
    func animateWithDuration(duration: NSTimeInterval, keypath: String!, animation: (anim: CABasicAnimation) -> Void, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock(completion)
        let anim = CABasicAnimation(keyPath: keypath)
        animation(anim: anim)
        anim.removedOnCompletion = true
        self.addAnimation(anim, forKey: nil)
        CATransaction.commit()
    }
    
}
