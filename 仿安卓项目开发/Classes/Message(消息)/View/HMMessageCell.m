//
//  HMMessageCell.m
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMMessageCell.h"
#import "HMMessageFrame.h"
#import "HMMessage.h"

@interface HMMessageCell ()

@property (nonatomic, weak) UILabel *lblTime;
@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UIButton *btnText;

@end

@implementation HMMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 动态创建子元素
        
        // 时间lable
        UILabel *lblTime =[[UILabel alloc] init];
        // 设置label中的文字大小
        lblTime.font = [UIFont systemFontOfSize:12];
        // 设置label的文字水平居中
        lblTime.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        
        // 头像
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        
        // 消息正文
        UIButton *btnText = [[UIButton alloc] init];
        // 设置文字颜色
        [btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // 设置正文的字体大小与计算的时候使用的字体大小一致
        btnText.titleLabel.font = HMTextFont;
        // 设置按钮的文字允许换行
        btnText.titleLabel.numberOfLines = 0;
        
        // 为按钮设置背景色
        //[btnText setBackgroundColor:[UIColor purpleColor]];
        
        
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
    }
    
    // 设置单元格的背景色
    self.backgroundColor = [UIColor clearColor];
    return self;
}


+ (instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"message_cell";
    HMMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HMMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}



- (void)setMessageFrame:(HMMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    // 获取数据模型
    HMMessage *model = messageFrame.message;
    
    // 1. 设置数据和frame
    
    // 发送时间
    self.lblTime.text = model.time;
    self.lblTime.frame = messageFrame.timeFrame;
    // 控制是否需要显示时间Label
    self.lblTime.hidden = messageFrame.hideTime;
    
    
    // 头像
    if (model.type == HMMessageTypeMe) {
        self.imgViewIcon.image = [UIImage imageNamed:@"icon"];
    } else {
        if (self.displayIconBlock) {
            self.displayIconBlock(self.imgViewIcon);
        } else {
            self.imgViewIcon.image = [UIImage imageNamed:@"other"];
        }
    }
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    
    // 消息正文
    [self.btnText setTitle:model.text forState:UIControlStateNormal];
    self.btnText.frame = messageFrame.textFrame;
    
    // 设置正文文字的颜色
    if (model.type == HMMessageTypeMe) {
        [self.btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    
    // 设置消息正文的背景图
    // 根据消息类型, 决定使用哪个图片
    NSString *nor, *highlighted;
    if (model.type == HMMessageTypeMe) {
        nor = @"chat_send_nor";
        highlighted = @"chat_send_press_pic";
    } else {
        nor = @"chat_recive_nor";
        highlighted = @"chat_recive_press_pic";
    }
    
    //创建图片
    UIImage *norImage = [UIImage imageNamed:nor];
    UIImage *highlightedImage = [UIImage imageNamed:highlighted];
    
    // 设置图片的拉伸方法
    norImage = [norImage stretchableImageWithLeftCapWidth:norImage.size.width * 0.5 topCapHeight:norImage.size.height * 0.5];
    highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:highlightedImage.size.width * 0.5 topCapHeight:highlightedImage.size.height * 0.5];
    
    
    // 设置按钮背景图
    [self.btnText setBackgroundImage:norImage forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    
    // 设置按钮内边距
    self.btnText.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
