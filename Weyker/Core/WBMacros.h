//
//  WBMacros.h
//  GenericProj
//
//  Created by Kevin Wu on 8/8/16.
//  Copyright © 2016 firefly.com. All rights reserved.
//

///------------
/// AppDelegate
///------------

#define WB_APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])


///---------
/// App Info
///---------

#define WB_APP_ID               @"961330940"
#define WB_APP_STORE_URL        @"https://itunes.apple.com/app/id"WB_APP_ID"?mt=8"
#define WB_APP_STORE_REVIEW_URL @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id="WB_APP_ID"&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"

#define WB_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define WB_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define WB_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


///-------
/// Screen
///-------
////////////////////////////////////////////////////////////////////////////////
//
// Screen Resolution
//
// Device       bounds      nativeBounds  scale nativeScale
// 4/4s         {320, 480}  {640, 960}    2.0   2.0
// 5/5s/SE      {320, 568}  {640, 1136}   2.0   2.0
// 6 /6s /7 /8  {375, 667}  {750, 1334}   2.0   2.0
// 6P/6sP/7P/8P {414, 736}  {1242, 2208}  3.0   3.0
// X/XS         {375, 812}  {1125, 2436}  3.0   3.0   (SafeArea: top44 bottom34)
// XR           {414, 896}  {828, 1792}   2.0   2.0   (SafeArea: top44 bottom34)
// XSM          {414, 896}  {1242, 2688}  3.0   3.0   (SafeArea: top44 bottom34)
//
////////////////////////////////////////////////////////////////////////////////

#define WB_SCREEN_WID  ([UIScreen mainScreen].bounds.size.width)
#define WB_SCREEN_HET ([UIScreen mainScreen].bounds.size.height)
#define WB_STATUS_BAR_HET (([UIScreen mainScreen].bounds.size.height>=812.0)?44.0:20.0)
#define WB_SAFE_AREA_TOP (([UIScreen mainScreen].bounds.size.height>=812.0)?44.0:0.0)
#define WB_SAFE_AREA_BOT (([UIScreen mainScreen].bounds.size.height>=812.0)?34.0:0.0)


///--------
/// Logging
///--------

#define WBPrintMethod() DDLogError(@"[%p][%@ %@]", self, NSStringFromClass([self class]), NSStringFromSelector(_cmd))


///-------
/// Number
///-------

#define WBStringRep(_a_) (@(_a_).stringValue)


///--------
/// Compare
///--------

// equal
#define WBEqual(_a_,_b_)       ([_a_ isEqual:_b_])
// not nil and equal
#define WBEqualStrong(_a_,_b_) ((_a_)&&([_a_ isEqual:_b_]))
// both nil or equal
#define WBEqualWeak(_a_,_b_)   ((!(_a_)&&!(_b_))||([_a_ isEqual:_b_]))

#define WBEqualFlt(_a_,_b_)  (fabsf(_a_-_b_)<FLT_EPSILON)
#define WBEqualDbl(_a_,_b_)  (fabs(_a_-_b_)<DBL_EPSILON)
