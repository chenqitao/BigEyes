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
#define TTScreenWidth    [UIScreen mainScreen].bounds.size.width
#define TTScreenHeight  [UIScreen mainScreen].bounds.size.height
#define TTIOSUIDevice   [[[UIDevice currentDevice] systemVersion] floatValue]
#define TTNavigationbarHeight  64
#define HeadViewHeight 200
#define naviH 64


#define TTSessionid @"sessionid"
#define TTuid       @"uid"
#define TTpassword  @"password"
#define TTname      @"name"


//第三方
#define MapKey      @"b48a23bbfcc57b6a89631a63a205cfc9"
#define UPYunurl    @"http://iscastest.b0.upaiyun.com"




//自己的API
#define TTImageListURL     @"/huhu/upload/discuz2app1/topiclist.php?type=second1"
#define TTPostPictureURL   @"/huhu/upload/discuz2app1/topiclist.php?type=submit"
#define TTGetDetailURL     @"/huhu/upload/discuz2app1/topiclist.php?type=thread_detail"
#define TTGetFavoutListURL @"/huhu/upload/discuz2app1/favourlist.php?type=favourlist"
#define TTGetFocusListURL  @"/huhu/upload/discuz2app1/topicfocuslist.php?type=focus"
#define TTDeleteFavourURL  @"/huhu/upload/discuz2app1/topicpost.php?type=deletefavour"
#define TTFavourURL        @"/huhu/upload/discuz2app1/topicpost.php?type=favour"
#define TTFocusURL         @"/huhu/upload/discuz2app1/topicpost.php?type=focus"
#define TTDeleteFocusURL   @"/huhu/upload/discuz2app1/topicpost.php?type=deletefocus"
#define TTcommentURL       @"/huhu/upload/discuz2app1/topicpost.php?type=reply&fid=2"
#define TTGetUserInfoURL   @"/huhu/upload/discuz2app1/setuserinfo.php?type=Select"
#define TTUploadFileURL    @"/huhu/upload/discuz2app1/topicpost.php?type=post1&fid=2&img=1"






#endif
