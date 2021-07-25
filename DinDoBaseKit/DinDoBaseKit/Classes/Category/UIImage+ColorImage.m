//
//  UIImage+ColorImage.m
//  ZanXiaoQu
//
//  Created by mac on 2017/12/1.
//  Copyright © 2017年 DianDu. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}
+ (UIImage *)imageWithRightOrientation:(UIImage *)aImage {  
    
    // No-op if the orientation is already correct  
    if (aImage.imageOrientation == UIImageOrientationUp)   
        return aImage;  
    
    // We need to calculate the proper transformation to make the image upright.  
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.  
    CGAffineTransform transform = CGAffineTransformIdentity;  
    
    switch (aImage.imageOrientation) {  
        case UIImageOrientationDown:  
        case UIImageOrientationDownMirrored:  
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);  
            transform = CGAffineTransformRotate(transform, M_PI);  
            break;  
            
        case UIImageOrientationLeft:  
        case UIImageOrientationLeftMirrored:  
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);  
            transform = CGAffineTransformRotate(transform, M_PI_2);  
            break;  
            
        case UIImageOrientationRight:  
        case UIImageOrientationRightMirrored:  
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);  
            transform = CGAffineTransformRotate(transform, -M_PI_2);  
            break;  
        default:  
            break;  
    }  
    
    switch (aImage.imageOrientation) {  
        case UIImageOrientationUpMirrored:  
        case UIImageOrientationDownMirrored:  
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);  
            transform = CGAffineTransformScale(transform, -1, 1);  
            break;  
            
        case UIImageOrientationLeftMirrored:  
        case UIImageOrientationRightMirrored:  
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);  
            transform = CGAffineTransformScale(transform, -1, 1);  
            break;  
        default:  
            break;  
    }  
    
    // Now we draw the underlying CGImage into a new context, applying the transform  
    // calculated above.  
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,  
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,  
                                             CGImageGetColorSpace(aImage.CGImage),  
                                             CGImageGetBitmapInfo(aImage.CGImage));  
    CGContextConcatCTM(ctx, transform);  
    switch (aImage.imageOrientation) {  
        case UIImageOrientationLeft:  
        case UIImageOrientationLeftMirrored:  
        case UIImageOrientationRight:  
        case UIImageOrientationRightMirrored:  
            // Grr...  
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);  
            break;  
            
        default:  
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);  
            break;  
    }  
    
    // And now we just create a new UIImage from the drawing context  
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);  
    UIImage *img = [UIImage imageWithCGImage:cgimg];  
    CGContextRelease(ctx);  
    CGImageRelease(cgimg);  
    return img;  
}  
+ (UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
//    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
+(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{

    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if(CGSizeEqualToSize(imageSize, size) == NO){

        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;

        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;

        }
        else{

            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        if(widthFactor > heightFactor){

            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){

            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }

    UIGraphicsBeginImageContext(size);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }

    UIGraphicsEndImageContext();
    return newImage;
}

@end
