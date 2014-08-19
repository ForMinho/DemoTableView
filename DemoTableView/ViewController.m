//
//  ViewController.m
//  DemoTableView
//
//  Created by For_SHINee on 14-7-16.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "ScrollowViewTableViewCell.h"
@interface ViewController ()
@property (strong, nonatomic) ScrollowViewTableViewCell *currentCell;
@end

@implementation ViewController
@synthesize tableView = _tableView;
@synthesize currentCell = _currentCell;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect mainRect = [UIScreen mainScreen].bounds;
    self.tableView = [[UITableView alloc] initWithFrame:mainRect style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = @"string";
    ScrollowViewTableViewCell *cell = (ScrollowViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[ScrollowViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        cell.delegate = self;
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.detailLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScrollowViewTableViewCell *cell = (ScrollowViewTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.revealing == YES) {
        cell.revealing = NO;
        [cell buttonViewScrollowToUI:MovedToRight];
        [cell setSelected:NO];
        return;
    }
}
- (void) set_isScrolled:(ScrollowViewTableViewCell *)cell
{
    if (self.currentCell != cell)
    {
        self.currentCell.revealing = NO;
        [self.currentCell buttonViewScrollowToUI:MovedToRight];
        self.currentCell = cell;
    }
}
- (void) getCollectedClicked:(ScrollowViewTableViewCell *)cell;
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
