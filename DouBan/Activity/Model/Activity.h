//
//  Activity.h
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownLoader.h"
@interface Activity : NSObject <ImageDownLoaderDelegate>
//列表界面请求的数据
@property (nonatomic,copy)NSString *image_hlarge;
@property (nonatomic,retain)UIImage *activity_pic;  //电影图片
@property (nonatomic)BOOL isLoading;  //是否正在下载


@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * begin_time;
@property (nonatomic,copy) NSString * end_time;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * category_name;
@property (nonatomic,copy) NSString * imageUrl;//图像网址
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * ownerName;
@property (nonatomic,copy) NSString * wisher_count;
@property (nonatomic,copy) NSString * participant_count;
@property (nonatomic,copy) NSString * image;//图像
@property (nonatomic,copy) NSString * time;


-(void)loadImage;
@end
