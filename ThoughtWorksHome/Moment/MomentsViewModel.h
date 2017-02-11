//
//  MomentsViewModel.h
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MomentsViewModel : NSObject

@property (nonatomic,copy) SuccessBlock sucBlock;
@property (nonatomic,copy) FailureBlock faiBlock;

- (void)setBlocksWithSucBlock:(SuccessBlock)sucBlock
                     faiBlock:(FailureBlock)faiBlock;

- (void)getUserInfo;

- (void)getTweetList;

@end
