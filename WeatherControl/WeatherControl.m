//
//  WeatherControl.m
//  WeatherControl
//
//  Created by Pulkit Rohilla on 11/08/16.
//  Copyright © 2018 PulkitRohilla. All rights reserved.
//

#import "WeatherControl.h"

@implementation WeatherControl{
    
    UIColor *fColor,*bColor;
    CAShapeLayer *backLayer, *drawingLayer;
    UIImage *imageWeather;
    
    float duration;
}

const static CGFloat innerMargin = 10;
const static CGFloat lineWidth = 0.5;

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //init images
    imageWeather = [UIImage imageNamed:@"weather"] ;
    
    CGRect innerRect = CGRectMake(rect.origin.x + (innerMargin/2 - lineWidth), rect.origin.y + (innerMargin/2 - lineWidth), rect.size.width - innerMargin, rect.size.height - innerMargin);
    
    int radius = innerRect.size.width/2;
    
    CGPoint center = CGPointMake(CGRectGetMidX(innerRect), CGRectGetMidY(innerRect) );
    CGPoint pathCenter = CGPointMake(CGRectGetMidX(innerRect) - radius, CGRectGetMidY(innerRect) - radius);
    
    backLayer = [CAShapeLayer layer];
    backLayer.bounds = self.bounds;
    backLayer.position = center;
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                    cornerRadius:radius];
    shape.path = path.CGPath;
    shape.position = pathCenter;
    shape.fillColor = bColor.CGColor;
    
    [shape setShadowOffset:CGSizeMake(1, 1)];
    [shape setShadowOpacity:0.25];
    [shape setShadowRadius:3];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageWeather];
    imageView.frame = CGRectMake(0,0, self.bounds.size.width/2, self.bounds.size.height/2);
    imageView.tintColor = fColor;
    imageView.center = center;

    
    [self.layer addSublayer:shape];
    [self.layer addSublayer:backLayer];
    [self addSubview:imageView];
}

-(void)setForeColor:(UIColor *)foreColor{
    
    fColor = foreColor;
}

-(void)setBackColor:(UIColor *)backColor{
    
    bColor = backColor;
}

-(void)setRotationDuration:(float)rotationDuration{
    
    duration = rotationDuration;
}

-(void)setHighlighted:(BOOL)highlighted{

    if (highlighted) {
        
        self.alpha = 0.5f;
    }
    else
    {
        self.alpha = 1.0f;
    }
    
    [super setHighlighted:highlighted];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {

        [self startAnimation];
    }

}

#pragma mark - PublicMethods

-(void)startAnimation
{
    CGRect rect = self.bounds;
    
    int radius = rect.size.width/2 - 4.5;
    
    CGPoint centerForArc = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:centerForArc radius:radius startAngle:3*M_PI/2 endAngle:0 clockwise:YES];
    
    drawingLayer = [CAShapeLayer layer];

    drawingLayer.lineWidth = 1.1f;
    drawingLayer.lineJoin = kCALineJoinBevel;
    drawingLayer.fillColor = [UIColor clearColor].CGColor;
    drawingLayer.strokeColor = fColor.CGColor;
    drawingLayer.lineCap = kCALineCapRound;
    drawingLayer.lineDashPattern =@[[NSNumber numberWithInt:1],[NSNumber numberWithInt:3]];
    
    [drawingLayer setPath:circlePath.CGPath];
    [backLayer addSublayer:drawingLayer];

    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = HUGE_VALF;

    [backLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)stopAnimation
{
    [drawingLayer removeFromSuperlayer];
    [backLayer removeAllAnimations];
}

@end
