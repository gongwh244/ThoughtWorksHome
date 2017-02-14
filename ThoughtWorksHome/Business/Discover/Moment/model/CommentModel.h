//
//  CommentModel.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/11.
//  Copyright © 2017年 gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SenderModel.h"

@interface CommentModel : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) SenderModel *sender;

@end
