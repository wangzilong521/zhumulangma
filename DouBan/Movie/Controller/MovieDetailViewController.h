//
//  MovieDetailViewController.h
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "MyDetailViewController.h"
#import "Movie.h"
@interface MovieDetailViewController : MyDetailViewController

@property (retain, nonatomic) IBOutlet UILabel *rateLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *genresLabel;
@property (retain, nonatomic) IBOutlet UILabel *countryLabel;
@property (retain, nonatomic) IBOutlet UILabel *actorsLabel;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UIImageView *movie_pic;

@property(nonatomic,retain)Movie *movie; 
@end
