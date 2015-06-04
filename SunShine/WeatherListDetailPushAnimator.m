//
//  WeatherListDetailPushAnimator.m
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherListDetailPushAnimator.h"
#define kTransitionDuration 0.35

@implementation WeatherListDetailPushAnimator
#pragma mark -- UIViewControllerContextTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionDuration;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    /*
     1)Manage the uiview hierarchy for transition.
     2)Use one animation block.
     3)Finish the animation
     */
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    //create rect frame top and bottom halves of the fromVC screen
    CGSize viewSize = fromViewController.view.bounds.size;
    CGRect topFrame = CGRectMake(0, 0, viewSize.width, viewSize.height/2);
    CGRect bottomFrame =  CGRectMake(0, viewSize.height/2, viewSize.width, viewSize.height/2);
    
    NSLog(@"viewSize:[%@],topFrame:[%@],bottomFrame:[%@]",NSStringFromCGSize(viewSize),NSStringFromCGRect(topFrame),NSStringFromCGRect(bottomFrame));
    
    //create snapshots, to slice up origin view and animate parts around the screen
    UIView *topSnapShot = [fromViewController.view resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO  withCapInsets:UIEdgeInsetsZero];
    UIView *bottomSnapShot = [fromViewController.view resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO  withCapInsets:UIEdgeInsetsZero];
    [topSnapShot setFrame:topFrame];
    [bottomSnapShot setFrame:bottomFrame];
    
    NSLog(@"topSnapShot:[%@],bottomSnapShot:[%@]",NSStringFromCGRect(topSnapShot.frame),NSStringFromCGRect(bottomSnapShot.frame));
    
    //remove the original container from the view
    [fromViewController.view removeFromSuperview];
    //add destination view
    [container addSubview:toViewController.view];
    
    //add snapshot on top
    [container addSubview:topSnapShot];
    [container addSubview:bottomSnapShot];
    
    //animate the view
    [UIView animateWithDuration:kTransitionDuration animations:^{
        //adjust the new frames
        CGRect newTopFrame = topFrame;
        CGRect newBottomFrame = bottomFrame;
        newTopFrame.origin.y -= topFrame.size.height;
        newBottomFrame.origin.y +=bottomFrame.size.height;
        
        //set the frame to animate it.
        [topSnapShot setFrame:newTopFrame];
        [bottomSnapShot setFrame:newBottomFrame];
        NSLog(@"animation started new topSnapShot[%@], bottomSnapShot[%@]",NSStringFromCGRect(newTopFrame),NSStringFromCGRect(newBottomFrame));
        
        
    } completion:^(BOOL finished) {
        NSLog(@"animation finished");
        //clean up from the views
        [topSnapShot removeFromSuperview];
        [bottomSnapShot removeFromSuperview];
        [transitionContext completeTransition:finished];
        
    }];
    
    
}
@end
