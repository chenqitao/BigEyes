//
//  TTGlobal.h
//  sinaForJackchen
//
//  Created by mac chen on 15/7/27.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#ifndef sinaForJackchen_TTGlobal_h
#define sinaForJackchen_TTGlobal_h

#define TTColor(r,g,b,alp)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alp]
#define TTScreenWith    [UIScreen mainScreen].bounds.size.width
#define TTScreenHeight  [UIScreen mainScreen].bounds.size.height
#define TTIOSUIDevice   [[[UIDevice currentDevice] systemVersion] floatValue]
#define TTNavigationbarHeight  64
#define HeadViewHeight 200
#define naviH 64


#import "TTHTTPRequest.h"
#import "TTUserDefaultTool.h"


#define TTSessionid @"sessionid"
#define TTuid       @"uid"
#define TTpassword  @"password"
#define TTname      @"name"








#define TTImageListURL     @"/huhu/upload/discuz2app1/topiclist.php?type=second1"
#define TTPostPictureURL   @"/huhu/upload/discuz2app1/topiclist.php?type=submit"
#define TTGetDetailURL     @"/huhu/upload/discuz2app1/topiclist.php?type=thread_detail"
#define TTGetFavoutListURL @"/huhu/upload/discuz2app1/favourlist.php?type=favourlist"
#define TTGetFocusListURL  @"/huhu/upload/discuz2app1/topicfocuslist.php?type=focus"





#endif
