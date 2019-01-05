//
//  WeatherControl.h
//  WeatherControl
//
//  Created by Pulkit Rohilla on 11/08/16.
//  Copyright © 2018 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WeatherControl : UIControl

@property (strong, nonatomic) IBInspectable UIColor *foreColor;
@property (strong, nonatomic) IBInspectable UIColor *backColor;

@property (nonatomic) IBInspectable float rotationDuration;

-(void)startAnimation;
-(void)stopAnimation;

@end
