
#import "BTWActionAlertDismissAnimator.h"

@interface BTWActionAlertDismissAnimator ()
{
    UIView *_fromView;
}
@end

@implementation BTWActionAlertDismissAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    _fromView = fromView;
    
    CGFloat scale = 0.01;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromView.transform = CGAffineTransformMakeScale(scale, scale);
        
    } completion:^(BOOL finished) {
        
        BOOL success = ![transitionContext transitionWasCancelled];
        
        [transitionContext completeTransition:success];
    }];
    
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if (transitionCompleted == YES) {
        [_fromView removeFromSuperview];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}


@end
