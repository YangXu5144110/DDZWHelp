//
//  AASeries.m
//  AAChartKit
//
//  Created by An An on 17/1/19.
//  Copyright ยฉ 2017ๅนด An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * ๐ ๐ ๐ ๐  โโโ   WARM TIPS!!!   โโโ ๐ ๐ ๐ ๐
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "AASeries.h"
#import "NSString+toPureJSString.h"

@implementation AASeries

AAPropSetFuncImplementation(AASeries, NSNumber     *, borderRadius) 
AAPropSetFuncImplementation(AASeries, AAMarker     *, marker) 
AAPropSetFuncImplementation(AASeries, NSString     *, stacking) 
AAPropSetFuncImplementation(AASeries, AAAnimation  *, animation) 
AAPropSetFuncImplementation(AASeries, NSArray      *, keys) 
//AAPropSetFuncImplementation(AASeries, BOOL , colorByPoint) //่ฎพ็ฝฎไธบ true ๅๆฏ็ปๆฏไธช็นๅ้้ข่ฒใ
AAPropSetFuncImplementation(AASeries, BOOL ,          connectNulls) 
AAPropSetFuncImplementation(AASeries, AAEvents *, events)
AAPropSetFuncImplementation(AASeries, AAShadow *, shadow)
AAPropSetFuncImplementation(AASeries, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AASeries, AAStates *, states)
AAPropSetFuncImplementation(AASeries, AAPoint  *, point)
AAPropSetFuncImplementation(AASeries, NSNumber *, borderRadiusTopLeft)
AAPropSetFuncImplementation(AASeries, NSNumber *, borderRadiusTopRight)
AAPropSetFuncImplementation(AASeries, NSNumber *, borderRadiusBottomLeft)
AAPropSetFuncImplementation(AASeries, NSNumber *, borderRadiusBottomRight)

@end


@implementation AAEvents

//AAPropSetFuncImplementation(AAEvents, NSString *, legendItemClick)

AAJSFuncTypePropSetFuncImplementation(AAEvents, NSString *, legendItemClick)

- (void)setLegendItemClick:(NSString *)legendItemClick {
    _legendItemClick = [legendItemClick aa_toPureJSString];
}

@end


@implementation AAPoint : NSObject

AAPropSetFuncImplementation(AAPoint, AAPointEvents     *, events)

@end


@implementation AAPointEvents : NSObject

//AAPropSetFuncImplementation(AAPointEvents, NSString *, click) //็นๅปไบไปถ
//AAPropSetFuncImplementation(AAPointEvents, NSString *, mouseOut) //้ผ?ๆ?ๅๅบ
//AAPropSetFuncImplementation(AAPointEvents, NSString *, mouseOver) //้ผ?ๆ?ๅ่ฟ
//AAPropSetFuncImplementation(AAPointEvents, NSString *, remove) //ๅ?้ค
//AAPropSetFuncImplementation(AAPointEvents, NSString *, select) //้ไธญ
//AAPropSetFuncImplementation(AAPointEvents, NSString *, unselect) //ๅๆถ้ไธญ
//AAPropSetFuncImplementation(AAPointEvents, NSString *, update) //ๆดๆฐ

AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, click) //็นๅปไบไปถ
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, mouseOut) //้ผ?ๆ?ๅๅบ
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, mouseOver) //้ผ?ๆ?ๅ่ฟ
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, remove) //ๅ?้ค
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, select) //้ไธญ
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, unselect) //ๅๆถ้ไธญ
AAJSFuncTypePropSetFuncImplementation(AAPointEvents, NSString *, update) //ๆดๆฐ

- (void)setClick:(NSString *)click {
    _click = [click aa_toPureJSString];
}

- (void)setMouseOut:(NSString *)mouseOut {
    _mouseOut = [mouseOut aa_toPureJSString];
}

- (void)setMouseOver:(NSString *)mouseOver {
    _mouseOver = [mouseOver aa_toPureJSString];
}

- (void)setRemove:(NSString *)remove {
    _remove = [remove aa_toPureJSString];
}

- (void)setSelect:(NSString *)select {
    _select = [select aa_toPureJSString];
}

- (void)setUnselect:(NSString *)unselect {
    _unselect = [unselect aa_toPureJSString];
}

- (void)setUpdate:(NSString *)update {
    _update = [update aa_toPureJSString];
}

@end
