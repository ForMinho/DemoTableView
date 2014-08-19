//
//  ScrollowViewTableViewCell.h
//  DemoTableView
//
//  Created by For_SHINee on 14-7-16.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MINGESTURE_MOVED 70 //滑动时所需要移动的最小距离
#define CENTERX_MOVED 140 //按钮滑动出的距离
typedef enum
{
    MovedNormal = 0,//未移动
    MovedToLeft,//向左移动
    MovedToRight,//向右移动
}MOVEDTYPE;
@class ScrollowViewTableViewCell;

@protocol ScrollowTableCellDelegate <NSObject>

- (void) set_isScrolled:(ScrollowViewTableViewCell *)cell;
- (void) getCollectedClicked:(ScrollowViewTableViewCell *)cell;
@end

@interface ScrollowViewTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>
@property (strong,nonatomic) UIView *buttonView;
@property (strong,nonatomic) UIButton *moreBtn;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *detailLabel;

@property (nonatomic, assign) MOVEDTYPE _isScrolledType;
@property (nonatomic, assign) float ViewCenterX;
@property (nonatomic,assign) BOOL revealing;
@property (strong,nonatomic) UIPanGestureRecognizer *_gestureRecognizer;


@property (weak, nonatomic ) id<ScrollowTableCellDelegate > delegate;

- (void) buttonViewScrollowToUI:(MOVEDTYPE) movedType;
@end

