//
//  AAStyle.h
//  AAChartKit
//
//  Created by An An on 17/1/6.
//  Copyright Â© 2017å¹´ An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

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

@interface AAStyle : NSObject

//Styles for the label. é»è®¤æ¯ï¼{"color": "contrast", "fontSize": "11px", "fontWeight": "bold", "textOutline": "1px 1px contrast" }.
AAPropStatementAndPropSetFuncStatement(copy, AAStyle, NSString *, color) //è®¾ç½®æå­çé¢è²,å¯ä¿®æ¹ä¸º #ff00ff ä»»æçè¿ç§åå­è¿å¶å­ç¬¦ä¸²
AAPropStatementAndPropSetFuncStatement(copy, AAStyle, NSString *, fontSize) //æå­å¤§å°
AAPropStatementAndPropSetFuncStatement(copy, AAStyle, NSString *, fontWeight) //å¯éçå¼æ bold, regularå thin ä¸ç§,åå«å¯¹åºçæ¯å ç²å­ä½,å¸¸è§å­ä½åçº¤ç»å­ä½
AAPropStatementAndPropSetFuncStatement(copy, AAStyle, NSString *, textOutline) //æå­è½®å»æè¾¹

+ (AAStyle *)styleWithColor:(NSString *)color;

+ (AAStyle *)styleWithColor:(NSString *)color
                   fontSize:(float)fontSize;

+ (AAStyle *)styleWithColor:(NSString *)color
                   fontSize:(float)fontSize
                 fontWeight:(NSString *)fontWeight;

+ (AAStyle *)styleWithColor:(NSString *)color
                   fontSize:(float)fontSize
                 fontWeight:(NSString *)fontWeight
                textOutline:(NSString *)textOutline;

@end

