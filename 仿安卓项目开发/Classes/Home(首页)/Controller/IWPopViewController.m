//
//  IWPopViewController.m
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWPopViewController.h"

@interface IWPopViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation IWPopViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@{ @"首页" : @[@"首页",
                               @"好友圈❤️",
                               @"群微博",
                                  @"我的微博"]},
                      @{@"我的分组" : @[@"特别关注",
                               @"音乐",
                               @"搞笑",
                                @"互联网",
                                @"名人明星",
                                @"同学",
                                    @"同事"]},
                      @{@"其他" : @[@"周边微博"]}
                   ];
    }
    return _array;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
//    lbl.text = [[self.array[section] allKeys] lastObject];
//    lbl.textColor = [UIColor whiteColor];
//    return lbl;
//}
//- (CGFloat)tableView:(UITableView *)tableView
//heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.array[section] allKeys] lastObject];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[self.array[section] allKeys] lastObject];
    NSArray *obj = [self.array[section] objectForKey:key];
    return obj.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    
    // Configure the cell...
    NSString *key = [[self.array[indexPath.section] allKeys] lastObject];
    NSArray *obj = [self.array[indexPath.section] objectForKey:key];
    
    cell.textLabel.text = obj[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}


@end
