//
//  TTHTTPRequest.h
//  sinaForJackchen
//
//  Created by mac chen on 15/7/27.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
typedef void (^TTHTTPRequestSuccessBlock)(id responseObject);
typedef void (^TTHTTPRequestFailedBlock)(NSError *error);
@interface TTHTTPRequest : AFHTTPRequestOperationManager
+(TTHTTPRequest *)shareHTTPRequest;

/**
 *  get 请求
 *
 *  @param method       请求地址
 *  @param parmars      请求参数
 *  @param successBlock 成功的block
 *  @param failedBlock  失败的block
 */


- (void)openAPIGetToMethod:(NSString *)method
                   parmars:(NSDictionary *)parmars
                   success:(TTHTTPRequestSuccessBlock)successBlock
                      fail:(TTHTTPRequestFailedBlock)failedBlock;

/**
 *  post 请求
 *
 *  @param method       请求地址
 *  @param parmars      请求参数
 *  @param successBlock 成功的block
 *  @param failedBlock  失败的block
 */
- (void)openAPIPostToMethod:(NSString *)method
                    parmars:(NSDictionary *)parmars
                    success:(TTHTTPRequestSuccessBlock)successBlock
                       fail:(TTHTTPRequestFailedBlock)failedBlock;

/**
 *  包括上传文件的 POST 请求
 *
 *  @param method       上传请求地址
 *  @param parmars      上传请求参数
 *  @param fileData     上传请求的文件Data:和fileURL二选一，没有为nil
 *  @param fileURL      上传请求的文件路径: 和fileData二选一，没有为nil
 *  @param name         上传文件的别名，不是文件名称
 *  @param successBlock 成功的block
 *  @param failedBlock  失败的block
 */
- (void)openAPIPostToMethod:(NSString *)method
                    parmars:(NSDictionary *)parmars
                       data:(NSData *)fileData
                    fineURL:(NSString *)filePath
                       name:(NSString *)name
                    success:(TTHTTPRequestSuccessBlock)successBlock
                       fail:(TTHTTPRequestFailedBlock)failedBlock;


/**
 *  post 请求(附带缓存)
 *
 *  @param method       请求地址
 *  @param parmars      请求参数
 *  @param needCache    是否需要缓存
 *  @param successBlock 成功的block
 *  @param failedBlock  失败的block
 *
 */
- (void)openAPIPostToMethod:(NSString *)method
                    parmars:(NSDictionary *)parmars
                  needCache:(BOOL)needCache
                    success:(TTHTTPRequestSuccessBlock)successBlock
                       fail:(TTHTTPRequestFailedBlock)failedBlock;

/**
 *  post 请求
 *
 *  @param api     请求地址
 *  @param dic     请求参数
 *  @param image   要上传的图片
 *  @param success 成功的block
 *  @param fail    失败的block
 */
- (void)requestPostWithApi:(NSString *)api
                 andParams:(NSDictionary *)dic
                  andImage:(UIImage *)image
                andSuccess:(TTHTTPRequestSuccessBlock)success
                   andfail:(TTHTTPRequestFailedBlock)fail;


@end
