//
//  config.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#ifndef config_h
#define config_h

typedef void(^SuccessBlock)(id returnData);
typedef void(^FailureBlock)(id returnData);

#define GET_USERINFO_URL                    @"http://thoughtworks-ios.herokuapp.com/user/jsmith"
#define GET_TWEETS_URL                      @"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets"

#define TWLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

//屏幕大小
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

#endif /* config_h */
