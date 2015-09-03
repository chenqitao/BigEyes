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

//默认密码
#define TTDefaultPwd @"0851888888"


#define TTSessionid  @"sessionid"
#define TTuid        @"uid"
#define TTpassword   @"password"
#define TTname       @"name"

//textfield.tag
#define SendtextfiledTag   1001
#define VerifytextfiledTag 1002
#define RegisttextfiledTag 1003


//第三方
#define MapKey       @"b48a23bbfcc57b6a89631a63a205cfc9"
#define UPYunurl     @"http://iscastest.b0.upaiyun.com"
#define UMAPPKEY     @"9fe57e168038"
#define UMAPPSecret  @"98dbb3a57295d4be74f39d088b5ff707"

//主页面数据
#define TTImageData  @"ImageData"
//关注界面数据
#define TTFocusData  @"FocusData"
//点赞数组数据
#define TTFavourData @"FavourData"
//详情帖子数据
#define TTDetailData @"DetailData"




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
#define TTRegistUCenterURL @"/huhu/upload/plugin.php?id=iphone:user&func=register"
#define TTLoginURL         @"/huhu/upload/discuz2app1/login.php?type=onlinedo"
#define TTactivationURL    @"http://123.57.48.206/huhu/upload/activation.php"







#endif
