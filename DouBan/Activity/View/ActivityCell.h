//
//  ActivityCell.h
//  DouBan
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *typeLable;
@property (retain, nonatomic) IBOutlet UILabel *interestedLable;
@property (retain, nonatomic) IBOutlet UILabel *attendLable;
@property (retain, nonatomic) IBOutlet UIImageView *activityImage;

@end
