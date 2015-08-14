//
//  TTHTTPRequest.m
//  sinaForJackchen
//
//  Created by mac chen on 15/7/27.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTHTTPRequest.h"
static NSString *baseURL = @"https://123.57.48.206";

@implementation TTHTTPRequest
+ (TTHTTPRequest *)shareHTTPRequest {
    static TTHTTPRequest *_sharedMMHTTPRequest = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMMHTTPRequest = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    return _sharedMMHTTPRequest;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}
- (void)openAPIGetToMethod:(NSString *)method
                   parmars:(NSDictionary *)parmars
                   success:(TTHTTPRequestSuccessBlock)successBlock
                      fail:(TTHTTPRequestFailedBlock)failedBlock {
      [self GET:method parameters:parmars success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"method=%@,parmars=%@",method,parmars);
     
              successBlock(responseObject);
      
                  
       
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
          failedBlock(error);
      }];
}

-(void)openAPIPostToMethod:(NSString *)method
                    parmars:(NSDictionary *)parmars
                    success:(TTHTTPRequestSuccessBlock)successBlock
                      fail:(TTHTTPRequestFailedBlock)failedBlock{
     [self POST:method parameters:parmars success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"method=%@,parmars=%@,responseObject=%@",method,parmars,responseObject);
      //   NSInteger code = [[responseObject objectForKey:@"code"] intValue];
        
             successBlock(responseObject);
//         } else  {//失败
//             if (!responseObject) {
//                 
//             } else {
//                 NSError *error = [[NSError alloc] initWithDomain:@"200" code:200 userInfo:@{NSLocalizedDescriptionKey:[responseObject objectForKey:@"message"]}];
//                 failedBlock(error);
//             }
//         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
         failedBlock(error);
     }];


}

- (void)openAPIPostToMethod:(NSString *)method
                    parmars:(NSDictionary *)parmars
                       data:(NSData *)fileData
                    fineURL:(NSString *)filePath
                       name:(NSString *)name
                    success:(TTHTTPRequestSuccessBlock)successBlock
                       fail:(TTHTTPRequestFailedBlock)failedBlock
{
    [self POST:method parameters:parmars constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (filePath) {
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            if (fileURL) {
                [formData appendPartWithFileURL:fileURL name:name error:nil];
            }
        } else if (fileData) {
            [formData appendPartWithFormData:fileData name:name];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"method=%@,parmars=%@,responseObject=%@",method,parmars,responseObject);
        NSInteger code = [[responseObject objectForKey:@"code"] intValue];
        if (code == 200) {//成功
            successBlock(responseObject);
        } else {//失败
            if (!responseObject) {
                failedBlock([responseObject objectForKey:@"code"]);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:@"200" code:200 userInfo:@{NSLocalizedDescriptionKey:[responseObject objectForKey:@"message"]}];
                failedBlock(error);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"method=%@,error=%@",method,error);
        failedBlock(error);
    }];
}


- (void)openAPIPostToMethod:(NSString *)method parmars:(NSDictionary *)parmars needCache:(BOOL)needCache success:(TTHTTPRequestSuccessBlock)successBlock fail:(TTHTTPRequestFailedBlock)failedBlock
{
    if (needCache) {
         id cache = [[TMCache sharedCache] objectForKey:[self dataCashFileNameWithMethod:method parmars:parmars]];
        if (cache) {
            successBlock(cache);
        }
    }
    [self POST:method
    parameters:parmars
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"method=%@,parmars=%@,responseObject=%@",method,parmars,responseObject);
           NSInteger code = [[responseObject objectForKey:@"code"] intValue];
           if (code == 200) {//成功
               successBlock(responseObject);
               if(needCache) {
                   [[TMCache sharedCache] setObject:responseObject forKey:[self dataCashFileNameWithMethod:method parmars:parmars]];
               }
           } else {//失败
               if (!responseObject) {
                   failedBlock([responseObject objectForKey:@"code"]);
               } else {
                   NSError *error = [[NSError alloc] initWithDomain:@"200" code:200 userInfo:@{NSLocalizedDescriptionKey:[responseObject objectForKey:@"message"]}];
                   failedBlock(error);
               }
           }
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"method=%@,error=%@",method,error);
           failedBlock(error);
       }];
}

- (NSString *)dataCashFileNameWithMethod:(NSString *)method
                                 parmars:(NSDictionary *)parmars {
    NSMutableString *str = [[NSMutableString alloc] init];
    [parmars enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [str appendString:[NSString stringWithFormat:@"%@",obj]];
    }];
    return [NSString stringWithFormat:@"%@_%@", method, str];
}


-(void)requestPostWithApi:(NSString *)api andParams:(NSDictionary *)dic andImage:(UIImage *)image andSuccess:(TTHTTPRequestSuccessBlock)success andfail:(TTHTTPRequestFailedBlock)fail{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValuesForKeysWithDictionary:dic];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.1);

    [self POST:api parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"file" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] integerValue]==200) {
            if (success) {
                success(responseObject);
            }
        } else {
            if (!responseObject) {
                fail([responseObject objectForKey:@"code"]);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:@"200" code:200 userInfo:@{NSLocalizedDescriptionKey:[responseObject objectForKey:@"message"]}];
                fail(error);
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"method=%@,error=%@",api,error);
        fail(error);

    }];
}

@end


