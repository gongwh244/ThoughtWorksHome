//
//  HttpRequestManager.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestManager : NSObject

+ (void)httpRequestGetWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)sucBlock
                      failure:(FailureBlock)faiBlock;

+ (void)httpRequestPostWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)sucBlock
                      failure:(FailureBlock)faiBlock;



@end
