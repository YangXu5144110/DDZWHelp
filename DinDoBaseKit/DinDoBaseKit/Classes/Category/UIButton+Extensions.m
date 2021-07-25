//
//  UIButton+Extensions.m
//  峰哥cells
//
//  Created by silence on 2017/9/3.
//  Copyright © 2017年 silence. All rights reserved.
//

// 按钮默认状态 图片在左,文字在右
////////////////////////////////
//  left      | right        ///
//  imageView | titleLable   ///
////////////////////////////////

#import "UIButton+Extensions.h"
#import "NSString+RegularExpression.h"

static const char Btn_ImgViewStyle_Key;
static const char Btn_ImgSize_key;
static const char Btn_ImgSpace_key;


@implementation UIButton (Extensions)




/**
 上部分是图片，下部分是文字
 
 @param space 间距
 */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // titleLabel的宽度不一定正确的时候，需要进行判断
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距上边框的距离增加imageView的高度+间距，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, -imageSize.width, -space, 0.0)];
    
    // 图片距右边框的距离减少图片的宽度，距离上面的间隔，其它不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width)];
}

/**
 左边是文字，右边是图片（和原来的样式翻过来）
 
 @param space 间距
 */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;

    // titleLabel的宽度不一定正确的时候，需要进行判断
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距左边框的距离减少imageView的宽度-间距，右侧增加距离imageView的宽度
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -imageSize.width - space, 0.0, imageSize.width)];
    
    // 图片距左边框的距离增加titleLable的宽度,距右边框的距离减少titleLable的宽度
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, titleSize.width,0.0,-titleSize.width)];
}

/**
 设置角标的个数（右上角）
 
 @param badgeValue <#badgeValue description#>
 */
- (void)setBadgeValue:(NSInteger)badgeValue{
    
    CGFloat badgeW   = 20;
    CGSize imageSize = self.imageView.frame.size;
    CGFloat imageX   = self.imageView.frame.origin.x;
    CGFloat imageY   = self.imageView.frame.origin.y;
    UILabel *badgeLable = [[UILabel alloc]init];
    if (badgeValue>100) {
        badgeLable.text = [NSString stringWithFormat:@"%ld",badgeValue];
        badgeLable.backgroundColor = [UIColor redColor];
        badgeLable.text =@"99+";
    }
    else if (badgeValue ==0) {
        badgeLable.text = [NSString stringWithFormat:@"%ld",badgeValue];
        badgeLable.backgroundColor = [UIColor clearColor];
        badgeLable.hidden=YES;
    }
 else if (badgeValue<99) {
     badgeLable.backgroundColor = [UIColor redColor];
        badgeLable.text = [NSString stringWithFormat:@"%ld",badgeValue];
    }
    badgeLable.textAlignment = NSTextAlignmentCenter;
    badgeLable.textColor = [UIColor whiteColor];
    badgeLable.font = [UIFont systemFontOfSize:12];
    badgeLable.layer.cornerRadius = badgeW*0.5;
    badgeLable.clipsToBounds = YES;
    CGFloat badgeX = imageX + imageSize.width - badgeW*0.5;
    CGFloat badgeY = imageY - badgeW*0.25;
    badgeLable.frame = CGRectMake(badgeX, badgeY, badgeW+10, badgeW);
    [self addSubview:badgeLable];
}

#pragma mark -- 调整btn的图片和文字的位置

- (void)setImgViewStyle:(ButtonImgViewStyle)style imageSize:(CGSize)size space:(CGFloat)space
{
    objc_setAssociatedObject(self, &Btn_ImgViewStyle_Key, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &Btn_ImgSpace_key, @(space), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &Btn_ImgSize_key, NSStringFromCGSize(size), OBJC_ASSOCIATION_COPY_NONATOMIC);
}


+ (void)load
{
    Method m1 = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method m2 = class_getInstanceMethod([self class], @selector(layoutSubviews1));
    method_exchangeImplementations(m1, m2);
}

- (void)layoutSubviews1
{
    [self layoutSubviews1];
    
    NSNumber *typeNum = objc_getAssociatedObject(self, &Btn_ImgViewStyle_Key);
    if (typeNum) {
        NSNumber *spaceNum = objc_getAssociatedObject(self, &Btn_ImgSpace_key);
        NSString *imgSizeStr = objc_getAssociatedObject(self, &Btn_ImgSize_key);
        CGSize imgSize = self.currentImage ? CGSizeFromString(imgSizeStr) : CGSizeZero;
        CGSize labelSize = self.currentTitle.length ? [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}] : CGSizeZero;
        
        CGFloat space = (labelSize.width && self.currentImage) ? spaceNum.floatValue : 0;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        CGFloat imgX = 0.0, imgY = 0.0, labelX, labelY;
        
        switch (typeNum.integerValue) {
            case ButtonImgViewStyleLeft:
            {
                imgX = (width - imgSize.width - labelSize.width - space)/2.0;
                imgY = (height - imgSize.height)/2.0;
                labelX = imgX + imgSize.width + space;
                labelY = (height - labelSize.height)/2.0;
                self.imageView.contentMode = UIViewContentModeRight;
                break;
            }
            case ButtonImgViewStyleTop:
            {
                imgX = (width - imgSize.width)/2.0;
                imgY = (height - imgSize.height - space - labelSize.height)/2.0;
                labelX = (width - labelSize.width)/2;
                labelY = imgY + imgSize.height + space;
                self.imageView.contentMode = UIViewContentModeBottom;
                break;
            }
            case ButtonImgViewStyleRight:
            {
                labelX = (width - imgSize.width - labelSize.width - space)/2.0;
                labelY = (height - labelSize.height)/2.0;
                imgX = labelX + labelSize.width + space;
                imgY = (height - imgSize.height)/2.0;
                self.imageView.contentMode = UIViewContentModeLeft;
                break;
            }
            case ButtonImgViewStyleBottom:
            {
                labelX = (width - labelSize.width)/2.0;
                labelY = (height - labelSize.height - imgSize.height -space)/2.0;
                imgX = (width - imgSize.width)/2.0;
                imgY = labelY + labelSize.height + space;
                self.imageView.contentMode = UIViewContentModeTop;
                break;
            }
            default:
                break;
        }
        self.imageView.frame = CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
        self.titleLabel.frame = CGRectMake(labelX, labelY, labelSize.width, labelSize.height);
    }
}

-(void)customBtnStyleUpImageDownTextWithText:(NSString *)text fontSize:(CGFloat)font img:(UIImage *)imag imgTopInterval:(CGFloat)imgTopInterval titleTopImgInterval:(CGFloat)titleTopImgInterval btnSize:(CGSize)btnSize{
    
    CGSize titleImgSize = imag.size;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:font];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitle:text forState:(UIControlStateNormal)];
    [self setImage:imag forState:(UIControlStateNormal)];
    CGFloat imgleft = btnSize.width/2-titleImgSize.width/2;
    self.imageEdgeInsets = UIEdgeInsetsMake(imgTopInterval, imgleft, 0, imgleft);
    CGSize titleSize = [self.titleLabel.text getTextRectWithFont:self.titleLabel.font textWidth:1000];
    self.titleEdgeInsets = UIEdgeInsetsMake(titleImgSize.height+titleTopImgInterval,  -titleImgSize.width+(btnSize.width-titleSize.width)/2, 0, 0);
}

@end
