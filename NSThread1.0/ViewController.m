//
//  ViewController.m
//  NSThread1.0
//
//  Created by 陈高健 on 15/11/26.
//  Copyright © 2015年 陈高健. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//图片视图
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation ViewController

//点击下载图片
- (IBAction)downLoadButton:(id)sender {
    //通过NSThread对象方法
    //[self objectMethod];
    //通过NSThread类方法
    //[self classMethod];
    //通过NSObject的方法
    [self extendedMethod];
}

//通过NSObject的方法去下载图片
- (void)extendedMethod{
    //通过NSObject分类方法
   [self performSelectorInBackground:@selector(downLoadImage) withObject:nil];//在后台操作,本质就是重新创建一个线程执行当前方法
   
}

//通过NSThread类方法去下载图片
- (void)classMethod{
    //NSThread类方法
    [NSThread detachNewThreadSelector:@selector(downLoadImage) toTarget:self withObject:nil];
}

//通过NSThread对象方法去下载图片
- (void)objectMethod{
    //创建一个程序去下载图片
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(downLoadImage) object:nil];
    NSLog(@"downLoadButton:%@",[NSThread currentThread]);//主线程
    //开启线程
    [thread start];
}

//下载图片
- (void)downLoadImage{
    //请求图片资源
    NSURL *url=[NSURL URLWithString:@"http://pic7.nipic.com/20100515/2001785_115623014419_2.jpg"];
    //模拟下载延迟
    [NSThread sleepForTimeInterval:10];
    //将图片资源转换为二进制
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSLog(@"downLoadImage:%@",[NSThread currentThread]);//在子线程中下载图片
    //在主线程更新UI
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
    
}
//更新imageView
- (void)updateImage:(NSData *)data{
    NSLog(@"updateImage:%@",[NSThread currentThread]);//在主线程中更新UI
    //将二进制数据转换为图片
    UIImage *image=[UIImage imageWithData:data];
    //设置image
    self.imageView.image=image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
