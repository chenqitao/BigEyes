//
//  RootTabView.m
//  sinaForJackchen
//
//  Created by mac chen on 15/7/29.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "RootTabView.h"

@implementation RootTabView


#pragma mark 设置button内部的image的范围

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    
    return CGRectMake(0, 5, imageW, imageH);
    
}

#pragma mark 设置button内部的title的范围

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}

@end
