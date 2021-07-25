//
//  UILabel+AttributedText.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UILabel+AttributedText.h"

@implementation UILabel (AttributedText)


+ (NSMutableAttributedString *)getAttributedStringWithFullText:(NSString *)fullText
                                                   replaceText:(NSString *)replaceText
                                                     textColor:(UIColor *)color
                                                      textFont:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullText];
    
    NSRange replaceRange = [fullText rangeOfString:replaceText];
    
    if (font) {
        
        [attributedString addAttribute:NSFontAttributeName value:font range:replaceRange];
    }
    
    if (color) {
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:replaceRange];
    }
    
    return attributedString;
}
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withSpacing:(CGFloat)spacing ImageName:(nonnull NSString *)imageName{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];
    if (imageName.length) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        //使用一张图片作为Attachment数据
        attachment.image = [UIImage imageNamed:imageName];
        //这里bounds的x值并不会产生影响
        attachment.bounds = CGRectMake(0, -2, 44, 14);
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [attributeStr appendAttributedString:imgStr];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
    }
    if (str) {
        NSAttributedString *imgStr = [[NSAttributedString alloc]initWithString:str];
        [attributeStr appendAttributedString:imgStr];
        
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = spacing; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    [attributeStr addAttributes:dic range:NSMakeRange(0, attributeStr.length)];
    label.attributedText = attributeStr;
}

@end
