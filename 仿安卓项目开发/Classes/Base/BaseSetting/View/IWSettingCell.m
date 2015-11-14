//
//  IWSettingCell.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSettingCell.h"

#import "IWBaseSetting.h"
#import "IWBadgeView.h"

@interface IWSettingCell ()

// 箭头
@property (nonatomic, strong) UIImageView *arrowView;
// cheak
@property (nonatomic, strong) UIImageView *cheakView;
// switch
@property (nonatomic, strong) UISwitch *switchView;
// badge
@property (nonatomic, strong) IWBadgeView *badgeView;

// label
@property (nonatomic, strong) UILabel *labelView;

@end

@implementation IWSettingCell
- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];

        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
       
    }
    return _labelView;
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        
        _arrowView = arrowView;

    }
    return _arrowView;
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
        
        _cheakView = arrowView;
        
    }
    return _cheakView;
}
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (IWBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [IWBadgeView buttonWithType:UIButtonTypeCustom];
    }
    return _badgeView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    IWSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setItem:(IWSettingItem *)item
{
    _item = item;
    
    // 设置内容
    [self setUpData];
    
    // 设置右边视图
    [self setUpRightView];
    
    if ([_item isKindOfClass:[IWLabelItem class]]) {
        IWLabelItem *labelItem = (IWLabelItem *)_item;
        self.labelView.text = labelItem.text;
        // 设置label
         [self addSubview:self.labelView];
    }else{// 不是就需要干掉
        [_labelView removeFromSuperview];
    }
}
// 设置内容
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

// 设置右边视图
- (void)setUpRightView
{
    if ([_item isKindOfClass:[IWArrowItem class]]) { // 箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[IWBadgeItem class]]){ // badgeView
        IWBadgeItem *badgeItem = (IWBadgeItem *)_item;
        self.badgeView.badgeValue = badgeItem.badgeValue;
        self.accessoryView = self.badgeView;
    }else if ([_item isKindOfClass:[IWSwitchItem class]]){ // switchView
        self.accessoryView = self.switchView;
    }else if ([_item isKindOfClass:[IWCheakItem class]]){ // cheakView
        IWCheakItem *cheakItem = (IWCheakItem *)_item;
        if (cheakItem.cheak) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    }else{
        self.accessoryView = nil;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelView.frame = self.bounds;
    
}



@end
