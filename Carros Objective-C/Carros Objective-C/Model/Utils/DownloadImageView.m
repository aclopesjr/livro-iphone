//
//  DownloadImageView.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/9/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "DownloadImageView.h"

@implementation DownloadImageView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createProgress];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createProgress];
    }
    return self;
}

- (void) createProgress {
    progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:progress];
}

- (void) layoutSubviews {
    progress.center = [self convertPoint:self.center toView:self.superview];
}

- (void) setUrl:(NSString*)url {
    [self setUrl:url withCache:true];
}

- (void) setUrl:(NSString*)url withCache:(BOOL)cache {
    self.image = nil;
    [progress startAnimating];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{ [self downloadImg:url withCache:cache]; }];
}

- (void) downloadImg:(NSString *)url withCache:(BOOL)cache {
    NSData * data = nil;
    if (!cache) {
        data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    } else {
        NSString * path = url;
        path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        path = [path stringByReplacingOccurrencesOfString:@"\\" withString:@"_"];
        path = [path stringByReplacingOccurrencesOfString:@":" withString:@"_"];
        path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), path];
        
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path] ) {
            data = [[NSData alloc] initWithContentsOfFile:path];
        } else {
            data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            [data writeToFile:path atomically:true];
        }
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{ [self showImg:data]; }];
}

- (void) showImg:(NSData *)data {
    if (data.length == 0) {
        return;
    }
    
    [self setImage:[UIImage imageWithData:data]];
    [progress stopAnimating];
}

@end
