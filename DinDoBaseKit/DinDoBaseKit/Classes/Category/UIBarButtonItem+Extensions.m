//
//  UIBarButtonItem+Extensions.m
//  AFNetworking
//
//  Created by 杨旭 on 2020/6/29.
//

#import "UIBarButtonItem+Extensions.h"

@implementation UIBarButtonItem (Extensions)

+ (UIBarButtonItem *)initLeftItems:(NSString *)title imageStr:(NSString *)imageStr target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:color_TextOne forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 200, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
    
}

@end
