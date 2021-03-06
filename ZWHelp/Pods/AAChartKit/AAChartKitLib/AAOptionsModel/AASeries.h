//
//  AASeries.h
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright Â© 2017å¹´ An An. All rights reserved.
//
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************
//

/*
 
 * -------------------------------------------------------------------------------
 *
 * ð ð ð ð  âââ   WARM TIPS!!!   âââ ð ð ð ð
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

#import <Foundation/Foundation.h>

@class AAMarker, AAAnimation, AAShadow, AADataLabels, AAEvents, AAStates, AAPoint;

@interface AASeries : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber     *, borderRadius) 
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAMarker     *, marker) 
AAPropStatementAndPropSetFuncStatement(copy,   AASeries, NSString     *, stacking) 
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAAnimation  *, animation) 
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSArray      *, keys) 
//colorByPoint å³å®äºå¾è¡¨æ¯å¦ç»æ¯ä¸ªæ°æ®åææ¯ä¸ªç¹åéä¸ä¸ªé¢è²ï¼é»è®¤å¼æ¯ falseï¼ å³é»è®¤æ¯ç»æ¯ä¸ªæ°æ®ç±»åéé¢è²ï¼
//AAPropStatementAndPropSetFuncStatement(assign, AASeries, BOOL , colorByPoint) //è®¾ç½®ä¸º true åæ¯ç»æ¯ä¸ªç¹åéé¢è²ã
//plotOptions.series.connectNulls
//https://www.zhihu.com/question/24173311
AAPropStatementAndPropSetFuncStatement(assign, AASeries, BOOL ,          connectNulls) //è®¾ç½®æçº¿æ¯å¦æ­ç¹éè¿
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAEvents *, events)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAShadow *, shadow)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAStates *, states)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, AAPoint  *, point)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, borderRadiusTopLeft)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, borderRadiusTopRight)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, borderRadiusBottomLeft)
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, borderRadiusBottomRight)

@end


@interface AAEvents : NSObject

AAPropStatementAndPropSetFuncStatement(copy, AAEvents, NSString *, legendItemClick)

@end


@class AAPointEvents;

@interface AAPoint : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAPoint, AAPointEvents *, events)

@end


@interface AAPointEvents : NSObject

AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, click) //ç¹å»äºä»¶
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, mouseOut) //é¼ æ ååº
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, mouseOver) //é¼ æ åè¿
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, remove) //å é¤
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, select) //éä¸­
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, unselect) //åæ¶éä¸­
AAPropStatementAndPropSetFuncStatement(copy, AAPointEvents, NSString *, update) //æ´æ°

@end

