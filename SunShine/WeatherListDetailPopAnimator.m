//
//  WeatherListDetailPopAnimator.m
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherListDetailPopAnimator.h"
#import "WeatherListViewController.h"
#import "WeatherDetailViewController.h"
#import "WeatherTableViewCell.h"


#define kTransitionDuration 0.40

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
    
    WeatherDetailViewController *fromViewController =(WeatherDetailViewController*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    WeatherListViewController *toViewController =(WeatherListViewController*) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    
   
    WeatherTableViewCell *selectedCell = (WeatherTableViewCell*)[toViewController tableViewCellForWeather:fromViewController.detailWeatherCondition];
    UIView *snapShotView =  [selectedCell.contentView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [container convertRect:selectedCell.frame fromView:fromViewController.view];
    //NSLog(@"snapShotView:%@",NSStringFromCGRect(snapShotView.frame));
    
    
    
    CGPoint viewPoint = snapShotView.frame.origin;
    CGSize viewSize = snapShotView.frame.size;
    CGRect topFrame =  CGRectMake(0, 0, viewSize.width, viewPoint.y);
    CGRect bottomFrame =  CGRectMake(0, viewPoint.y, viewSize.width, (fromViewController.view.bounds.size.height)- viewPoint.y);
    
    
    //NSLog(@"viewPoint:[%@],topFrame:[%@],bottomFrame:[%@]",NSStringFromCGPoint(viewPoint),NSStringFromCGRect(topFrame),NSStringFromCGRect(bottomFrame));
    
    //create snapshots, to slice up origin view and animate parts around the screen
    UIView* snapshot = [toViewController.view snapshotViewAfterScreenUpdates:YES];

    UIView *topSnapShot = [snapshot resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO  withCapInsets:UIEdgeInsetsZero];
    UIView *bottomSnapShot = [snapshot resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO  withCapInsets:UIEdgeInsetsZero];
    
    //NSLog(@"Before topSnapShot:[%@],bottomSnapShot:[%@]",NSStringFromCGRect(topSnapShot.frame),NSStringFromCGRect(bottomSnapShot.frame));

    
    //start the frames with an offset
    CGRect topFrameOffset = topFrame;
    CGRect bottomFrameOffset = bottomFrame;
    topFrameOffset.origin.y -= topFrame.size.height;
    bottomFrameOffset.origin.y += bottomFrame.size.height;
    topSnapShot.frame = topFrameOffset;
    bottomSnapShot.frame = bottomFrameOffset;
    
    //NSLog(@"After topSnapShot:[%@],bottomSnapShot:[%@]",NSStringFromCGRect(topSnapShot.frame),NSStringFromCGRect(bottomSnapShot.frame));
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
