//
//  MomentsViewModel.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "MomentsViewModel.h"
#import "HttpRequestManager.h"
#import "UserModel.h"

@interface MomentsViewModel ()

@property (nonatomic,strong) UserModel *userModel;

@end

@implementation MomentsViewModel


- (void)setBlocksWithSucBlock:(SuccessBlock)sucBlock faiBlock:(FailureBlock)faiBlock{
    self.sucBlock = sucBlock;
    self.faiBlock = faiBlock;
}

- (void)getUserInfo{
    
    [HttpRequestManager httpRequestGetWithUrl:GET_USERINFO_URL parameter:nil success:^(id returnData) {
        [self userModelFromDic:returnData];
    } failure:^(id returnData) {
        
    }];
}

- (void)userModelFromDic:(id)dic{
    
    NSDictionary *dict = (NSDictionary *)dic;
    self.userModel = [[UserModel alloc] init];
    self.userModel.avatar = [dict objectForKey:@"avatar"];
    self.userModel.nick = [dict objectForKey:@"nick"];
    self.userModel.profileImage = [dict objectForKey:@"profile-image"];
    self.userModel.userName = [dict objectForKey:@"username"];
    self.sucBlock(self.userModel);
}


@end
