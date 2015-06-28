//
//  ActivityViewController.h
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "MyDetailViewController.h"
#import "Activity.h"
@interface ActivityViewController : MyDetailViewController
@property (retain, nonatomic) IBOutlet UIImageView *activityImage;
@property (retain, nonatomic) IBOutlet UILabel *titleLable;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *nameLable;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic,retain)Activity *activity;
@end
