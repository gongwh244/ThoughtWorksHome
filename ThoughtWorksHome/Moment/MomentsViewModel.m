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
#import "SenderModel.h"
#import "TweetModel.h"
#import "CommentModel.h"

@interface MomentsViewModel ()

@property (nonatomic,strong) UserModel *userModel;
@property (nonatomic,strong) NSMutableArray *tweetArr;

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

- (void)getTweetList{
    [HttpRequestManager httpRequestGetWithUrl:GET_TWEETS_URL parameter:nil success:^(id returnData) {
        TWLog(@"hahah = %@",returnData);
        [self tweetArrayFromArr:returnData];
    } failure:^(id returnData) {
        
    }];
}

- (void)tweetArrayFromArr:(id)arr{
    
    self.tweetArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in (NSArray *)arr) {
        
        if (!dic[@"sender"]) {
            continue;
        }
        if (!dic[@"content"] && !dic[@"images"]) {
            continue;
        }
        
        NSDictionary *sender = dic[@"sender"];
        SenderModel *sModel = [[SenderModel alloc] init];
        sModel.avatar = sender[@"avatar"];
        sModel.nick = sender[@"nick"];
        sModel.username = sender[@"username"];
        
        NSArray *imageArr = dic[@"images"];
        NSMutableArray *imgArray = [[NSMutableArray alloc] init];
        if (imageArr && imageArr.count > 0) {
            for (NSDictionary *urlDic in imageArr) {
                [imgArray addObject:urlDic[@"url"]];
            }
        }
        
        NSArray *comArr = dic[@"comments"];
        NSMutableArray *commentArray = [[NSMutableArray alloc] init];
        if (comArr && comArr.count > 0) {
            for (NSDictionary *commDic in comArr) {
                [commentArray addObject:[self comModelFromDic:commDic]];
            }
        }
        
        TweetModel *model = [[TweetModel alloc] init];
        model.sender = sModel;
        model.content = dic[@"content"];
        model.images = imgArray;
        model.comments = commentArray;
        
        [self.tweetArr addObject:model];
    }
    self.sucBlock(self.tweetArr);
}

- (CommentModel *)comModelFromDic:(NSDictionary *)dic{
    
    SenderModel *sender = [[SenderModel alloc] init];
    sender.avatar = dic[@"sender"][@"avatar"];
    sender.nick = dic[@"sender"][@"nick"];
    sender.username = dic[@"sender"][@"username"];
    
    CommentModel *model = [[CommentModel alloc] init];
    model.content = dic[@"content"];
    model.sender = sender;
    
    return model;
}





















@end
