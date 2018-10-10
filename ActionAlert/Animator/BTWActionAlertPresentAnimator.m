

#import "BTWActionAlertPresentAnimator.h"

@implementation BTWActionAlertPresentAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGFloat containerW = CGRectGetWidth(containerView.frame);
    CGFloat containerH = CGRectGetHeight(containerView.frame);
    
    CGFloat toViewW = self.vcSize.width;
    CGFloat toViewH = self.vcSize.height;
    CGFloat toViewX = (containerW - toViewW) / 2;
    CGFloat toViewY = (containerH - toViewH) / 2;

    toView.frame = CGRectMake(toViewX, toViewY, toViewW, toViewH);
    
    CGFloat scale = 0.01;
    
    toView.transform = CGAffineTransformMakeScale(scale, scale);
    
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        
        BOOL success = ![transitionContext transitionWasCancelled];
        
        if (success == NO) {
            [toView removeFromSuperview];
        }
        
        [transitionContext completeTransition:success];
    }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}


@end
