//
//  Movie.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "Movie.h"
#import "FileHandle.h"
#import "NSObject+NSCoding.h"
@implementation Movie
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
    if ([key isEqualToString:@"pic_url"]) {
        NSString *imageURL = (NSString *)value;
        
        //获取本地对应图片路径
        NSString *imagePath = [[FileHandle shareHandle] getImageFilePathWithImageURL:imageURL];
        
        //获取图片并赋值
        self.movie_pic = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//请求图片
-(void)loadImage
{
    [[ImageDownLoader alloc] initWithImageURL:self.pic_url delegate:self];
    _isLoading = YES;  //正在请求
}
//请求成功
-(void)imageDownLoader:(ImageDownLoader *)imageDownLoader didSucceedWithImage:(UIImage *)image
{
    self.movie_pic = image;
    _isLoading = NO;  //请求结束
    
    //图片缓存
    
    //获取图片文件路径
    NSString *imagePath = [[FileHandle shareHandle] getImageFilePathWithImageURL:self.pic_url];
    //缓存
    [[FileHandle shareHandle] saveDownImageWithImage:image filePath:imagePath];
}
@end
