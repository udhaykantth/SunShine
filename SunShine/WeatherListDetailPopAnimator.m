//
//  WeatherListDetailPopAnimator.m
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherListDetailPopAnimator.h"

#define kTransitionDuration 0.35

@implementation WeatherListDetailPopAnimator

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
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    //create rect frame top and bottom halves of the fromVC screen
    CGSize viewSize = fromViewController.view.bounds.size;
    CGRect topFrame = CGRectMake(0, 0, viewSize.width, viewSize.height/2);
    CGRect bottomFrame =  CGRectMake(0, viewSize.height/2, viewSize.width, viewSize.height/2);
    
    NSLog(@"viewSize:[%@],topFrame:[%@],bottomFrame:[%@]",NSStringFromCGSize(viewSize),NSStringFromCGRect(topFrame),NSStringFromCGRect(bottomFrame));
    
    //create snapshots, to slice up origin view and animate parts around the screen
    UIView* snapshot = [toViewController.view snapshotViewAfterScreenUpdates:YES];

    UIView *topSnapShot = [snapshot resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO  withCapInsets:UIEdgeInsetsZero];
    UIView *bottomSnapShot = [snapshot resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO  withCapInsets:UIEdgeInsetsZero];
    
    NSLog(@"Before topSnapShot:[%@],bottomSnapShot:[%@]",NSStringFromCGRect(topSnapShot.frame),NSStringFromCGRect(bottomSnapShot.frame));

    
    //start the frames with an offset
    CGRect topFrameOffset = topFrame;
    CGRect bottomFrameOffset = bottomFrame;
    topFrameOffset.origin.y -= topFrame.size.height;
    bottomFrameOffset.origin.y += bottomFrame.size.height;
    topSnapShot.frame = topFrameOffset;
    bottomSnapShot.frame = bottomFrameOffset;
    
    NSLog(@"After topSnapShot:[%@],bottomSnapShot:[%@]",NSStringFromCGRect(topSnapShot.frame),NSStringFromCGRect(bottomSnapShot.frame));
    //add snapshot on top
    [container addSubview:topSnapShot];
    [container addSubview:bottomSnapShot];
    
    //animate the view
    [UIView animateWithDuration:kTransitionDuration animations:^{
        
         //set the frames back to original place during animation.
        topSnapShot.frame = topFrame;
        bottomSnapShot.frame = bottomFrame;
        
    } completion:^(BOOL finished){
        
        //clean up from the views
        [topSnapShot removeFromSuperview];
        [bottomSnapShot removeFromSuperview];
        
        [fromViewController.view removeFromSuperview];
        [container addSubview:toViewController.view];
        
        [transitionContext completeTransition:finished];
    }];
    
    
    
    
}
@end
