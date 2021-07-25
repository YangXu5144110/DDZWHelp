//
//  TipMsg.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#ifndef TipMsg_h
#define TipMsg_h

//                   --------- 提示文字 ---------

#define TIP_NETWORK_NO_CONNECTION @"网络连接失败" /**<无网络*/
#define TIP_NETWORK_TIMEOUT @"网络请求超时" /**<请求超时*/
#define TIP_RESPONSE_DATA_ERR @"获取数据失败" /**<请求超时*/

//                      ------ 网络请求返回code ------
#define RSP_SUCCESS             @"1"                 /**< 网络请求成功 */

// 请求数据size
#define REQUEST_PAGE_SIZE     @"20"

// toastView
#define KPOP(msg)  [TotastView showWithText:msg bottomOffset:kHEIGHT/2];



#endif /* TipMsg_h */
