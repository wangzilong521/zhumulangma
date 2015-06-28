//
//  Activity.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "Activity.h"
#import "FileHandle.h"
#import "NSObject+NSCoding.h"
@implementation Activity
//获取时间
-(NSString *)time
{
    //开始时间  结束时间的截取
    NSString *beginTime = [self.begin_time substringWithRange:NSMakeRange(5,11)];
    NSString *endTime = [self.end_time substringWithRange:NSMakeRange(5, 11)];
    
    //拼接
    self.time = [beginTime stringByAppendingFormat:@" -- %@",endTime];
    
    return _time;
    
}

//重写encode
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [self autoEncodeWithCoder:aCoder];
}
//重写初始化
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self autoDecode:aDecoder];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    //    NSLog(@"%@",key);
    //通过判断   找到key: pic_url 找到图片网址
    if ([key isEqualToString:@"image_hlarge"]) {
        NSString *imageURL = (NSString *)value;
        NSLog(@"%@",value);
        //获取本地对应图片路径
        NSString *imagePath = [[FileHandle shareHandle] getImageFilePathWithImageURL:imageURL];
        
        //获取图片并赋值
        self.activity_pic = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }else if ([key isEqualToString:@"participant_count"])
    {
        //value 是参加人数 NSNumber的对象
        self.participant_count = [NSString stringWithFormat:@"%@",value];
    }else if ([key isEqualToString:@"wisher_count"])
    {
        self.wisher_count = [NSString stringWithFormat:@"%@",value];
    }


}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"owner"]) {
        self.ownerName = [value valueForKey:@"name"];
    }
}
//请求图片
-(void)loadImage
{
    [[ImageDownLoader alloc] initWithImageURL:self.image_hlarge delegate:self];
    _isLoading = YES;  //正在请求
}
//请求成功
-(void)imageDownLoader:(ImageDownLoader *)imageDownLoader didSucceedWithImage:(UIImage *)image
{
    self.activity_pic = image;
    _isLoading = NO;  //请求结束
    
    
    //图片缓存
    
    //获取图片文件路径
    NSString *imagePath = [[FileHandle shareHandle] getImageFilePathWithImageURL:self.image_hlarge];
    //缓存
    [[FileHandle shareHandle] saveDownImageWithImage:image filePath:imagePath];
}

@end
