//
//  DownloadImageView.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/9/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageView : UIImageView {
    // MARK: Local Variables
    UIActivityIndicatorView * progress;
}

- (void) createProgress;
- (void) setUrl:(NSString *)url;
- (void) setUrl:(NSString *)url withCache:(BOOL)cache;
- (void) downloadImg:(NSString *)url withCache:(BOOL)cache;
- (void) showImg:(NSData *)data;

@end
