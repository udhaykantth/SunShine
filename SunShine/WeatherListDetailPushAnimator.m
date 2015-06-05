//
//  WeatherListDetailPushAnimator.m
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherListDetailPushAnimator.h"
#import "WeatherListViewController.h"
#import "WeatherDetailViewController.h"
#import "WeatherTableViewCell.h"

#define kTransitionDuration 0.40

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
    WeatherDetailViewController *toViewController =(WeatherDetailViewController*) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     WeatherListViewController *fromViewController =(WeatherListViewController*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    UIView *container = [transitionContext containerView];
 
    WeatherTableViewCell *selectedCell = (WeatherTableViewCell*)[fromViewController.tableView cellForRowAtIndexPath:[[fromViewController.tableView indexPathsForSelectedRows] firstObject]];
    UIView *snapShotView =  [selectedCell.contentView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [container convertRect:selectedCell.frame fromView:fromViewController.view];
    NSLog(@"snapShotView:%@",NSStringFromCGRect(snapShotView.frame));

    
    
     CGPoint viewPoint = snapShotView.frame.origin;
     CGSize viewSize = snapShotView.frame.size;
     CGRect topFrame =  CGRectMake(0, 0, viewSize.width, viewPoint.y);
     CGRect bottomFrame =  CGRectMake(0, viewPoint.y, viewSize.width, (fromViewController.view.bounds.size.height)- viewPoint.y);
    
    
    NSLog(@"viewPoint:[%@],topFrame:[%@],bottomFrame:[%@]",NSStringFromCGPoint(viewPoint),NSStringFromCGRect(topFrame),NSStringFromCGRect(bottomFrame));
    
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
