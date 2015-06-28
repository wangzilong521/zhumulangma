//
//  ActivityCell.m
//  DouBan
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLabel release];
    [_timeLabel release];
    [_addressLabel release];
    [_typeLable release];
    [_interestedLable release];
    [_attendLable release];
    [_activityImage release];
    [super dealloc];
}
@end
