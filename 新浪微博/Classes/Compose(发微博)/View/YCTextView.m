//
//  YCTextView.m
//  新浪微博
//
//  Created by yc on 15-4-17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YCTextView.h"
#import "HMTextAttachment.h"
//#import "<#header#>"

@interface YCTextView ()
@property (nonatomic, weak) IBOutlet UILabel *placeHolder;
@end

@implementation YCTextView
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    UILabel *lable = [[UILabel alloc] init];
    self.placeHolder = lable;
    lable.font = [UIFont systemFontOfSize:15];
    lable.text = @"请输入要发送的内容";
    lable.x = 5;
    lable.y = 7;
    [lable sizeToFit];
    [self addSubview:lable];
    // 监听自己的文字内容变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textviewDidChanged) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textviewDidChanged
{
    self.placeHolder.hidden = (self.text.length > 0);
}

// 重写set方法保证每次都刷新frame
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeHolder.text = placeholder;
    [self.placeHolder sizeToFit];
}
// 在每次设置文本字体的时候刷新frame
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self.placeHolder sizeToFit];
    // 当改变文本框字体时同时设置占位字符的字体
    self.placeHolder.font = font;
    [self.placeHolder sizeToFit];
}

- (void)setEmoticonStr:(HMEmoticon *)emoticon
{
    // 1.生成表情
    NSAttributedString *emoticonStr = [HMTextAttachment attributedStringWithEmoticon:emoticon fontHeight:self.font.lineHeight];
    
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    // 3.将图片属性字符串插入到strM光标所在的位置
    [strM replaceCharactersInRange:self.selectedRange withAttributedString:emoticonStr];
    NSRange range = NSMakeRange(0, strM.length);
    [strM addAttribute:NSFontAttributeName value:self.font range:range];
    
    NSUInteger location = self.selectedRange.location;
    // 4.赋值给customTextView
    // 每次赋值会改变光标的位置, 到最后
    self.attributedText = strM;
    // 重新设置光标选中的位置
    self.selectedRange = NSMakeRange(location + 1, 0);
}
// 完整发送字符串
- (NSString *)fullTextStr
{
    // 5.获取用户输入的内容
    // 1.定义个字符串保存最终需要发送的文本
    NSMutableString *temp = [NSMutableString string];
    // 2.遍历属性字符串
    NSRange range = NSMakeRange(0, self.attributedText.length);
    [self.attributedText enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        // 判断是普通字或者是emoji
        if (attrs[@"NSAttachment"] == nil) {
            // 普通文字, 或者emoji
            NSString *norStr = [self.text substringWithRange:range];
            // 拼接字符串
            [temp appendString:norStr];
        }else{
            // 自定义表情图片
            HMTextAttachment *attachment = attrs[@"NSAttachment"];
            // 查找对应表情的文字, 添加到字符串中即可
            [temp appendString:attachment.chs];
        }
    }];
    NSLog(@"temp = %@", temp);
    return temp;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
