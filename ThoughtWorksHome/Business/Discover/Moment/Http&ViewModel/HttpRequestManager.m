//
//  HttpRequestManager.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "HttpRequestManager.h"

@implementation HttpRequestManager


+ (void)httpRequestGetWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)sucBlock
                      failure:(FailureBlock)faiBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        faiBlock(error);
    }];
}

+ (void)httpRequestPostWithUrl:(NSString *)url
                     parameter:(NSDictionary *)parameter
                       success:(SuccessBlock)sucBlock
                       failure:(FailureBlock)faiBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faiBlock(error);
    }];
}



@end
