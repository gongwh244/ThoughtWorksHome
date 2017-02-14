//
//  TweetModel.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/11.
//  Copyright © 2017年 gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SenderModel.h"

@interface TweetModel : NSObject

@property (nonatomic,strong) SenderModel *sender;
@property (nonatomic,strong) NSArray *comments;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSArray *images;

@end
