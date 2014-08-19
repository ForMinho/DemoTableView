//
//  ScrollowViewTableViewCell.m
//  DemoTableView
//
//  Created by For_SHINee on 14-7-16.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ScrollowViewTableViewCell.h"
@interface ScrollowViewTableViewCell()
{
    float startRcognizerRect;
    float startViewCenterX;
}
@end


@implementation ScrollowViewTableViewCell
@synthesize buttonView = _buttonView;
@synthesize moreBtn = _moreBtn;
@synthesize titleLabel = _titleLabel;
@synthesize textLabel = _textLabel;
@synthesize _isScrolledType = __isScrolledType;
@synthesize ViewCenterX = _ViewCenterX;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect cellRect = self.frame;
        cellRect.size.height = cellRect.size.height/2;
        cellRect.origin.y = 10;
        self.titleLabel = [[UILabel alloc] initWithFrame:cellRect];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [self.contentView addSubview:self.titleLabel];
        
        
        cellRect.origin.y += cellRect.size.height;
        cellRect.size.height = cellRect.size.height * 0.9;
        self.detailLabel = [[UILabel alloc] initWithFrame:cellRect];
        [self.detailLabel setTextAlignment:NSTextAlignmentCenter];
        [self.detailLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self.contentView addSubview:self.detailLabel];
        
        self._gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(getGestureRecognizer:)];
        [self._gestureRecognizer setDelegate:self];
        [self addGestureRecognizer:self._gestureRecognizer];
        startViewCenterX = self.ViewCenterX = self.center.x;
//        NSLog(@"self.ViewCenterX = %f",self.ViewCenterX);
//        [self loadButtonView];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- UIGestureRecognizer
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer == self._gestureRecognizer)
    {
		UIScrollView *superview = (UIScrollView *)self.superview;
		CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:superview];
		// Make it scrolling horizontally 判断是横向的滑动
		return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO &&
                (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
	}
	return YES;
}
- (void)getGestureRecognizer:(UIGestureRecognizer *)_gestureRecognizer
{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    switch (_gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            startRcognizerRect = [_gestureRecognizer locationInView:self].x;
            if (self._isScrolledType == MovedNormal) {
                [self loadButtonView];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            float movedRecognizerX = [_gestureRecognizer locationInView:self].x;
            float movedDistance = movedRecognizerX - self.ViewCenterX;
//            向右滑动，不做处理
            if (movedDistance > 0 && self._isScrolledType == MovedNormal) {
                
            }
//            向左滑动,且滑动距离达到判断值
            else if(movedDistance < -MINGESTURE_MOVED  && self._isScrolledType == MovedNormal)
            {
                self._isScrolledType = MovedToLeft;
                [self buttonViewScrollowToUI:self._isScrolledType];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            [self _setIsScrolled:YES];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        {
            [self _setIsScrolled:YES];
        }
            break;
            
        default:
            break;
    }
}
-  (void)loadButtonView
{
    if (self.buttonView == nil) {
        CGRect cellRect = self.frame;
        cellRect.origin.x += cellRect.size.width;
        cellRect.origin.y = 0;
        self.buttonView = [[UIView alloc] initWithFrame:cellRect];
        [self.buttonView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:self.buttonView];
        
//        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.moreBtn setFrame:CGRectMake(0, 0, 100, self.buttonView.frame.size.height)];
        self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, self.buttonView.frame.size.height)];
        
        [self.moreBtn setTitle:@"more button" forState:UIControlStateNormal];
        [self.moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.moreBtn addTarget:self action:@selector(moreButtonClicked)
               forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonView addSubview:self.moreBtn];
        
    }
}
- (void) buttonViewScrollowToUI:(MOVEDTYPE) movedType
{
    
    switch (movedType) {
        case  MovedNormal:
        {
            
        }
            break;
            
        case MovedToLeft:
        {
            self.revealing = YES;
            [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.ViewCenterX -= CENTERX_MOVED;
                self.center = CGPointMake(self.ViewCenterX, self.center.y);
                self.buttonView.center = CGPointMake(self.buttonView.center.x - CENTERX_MOVED, self.buttonView.center.y);
            }completion:^(BOOL finished){
                
            }];
        }
            break;
            
        case MovedToRight:
        {
            self.revealing = NO;
            if (self.ViewCenterX == startViewCenterX) {
                return;
            }
            [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.ViewCenterX += CENTERX_MOVED;
                self.center = CGPointMake(self.ViewCenterX, self.center.y);
                self.buttonView.center = CGPointMake(self.buttonView.center.x + CENTERX_MOVED, self.buttonView.center.y);
            }completion:^(BOOL finished){
                
            }];
        }
            break;
        default:
            break;
    }
    self._isScrolledType = MovedNormal;
}

- (void) _setIsScrolled:(BOOL)revealing
{
    _revealing = revealing;
    if (self.delegate && [self.delegate respondsToSelector:@selector(set_isScrolled:)]) {
        [self.delegate set_isScrolled:self];
    }
}

- (void)moreButtonClicked
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCollectedClicked:)]) {
        [self.delegate getCollectedClicked:self];
    }
}
@end
