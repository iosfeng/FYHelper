//
// Created by efeng on 2017/3/7.
// Copyright (c) 2017 weiboyi. All rights reserved.
//

#import "UIView+FYBlockGesture.h"
#import <objc/runtime.h>

static char fy_kFYTapBlockKey;
static char fy_kFYLongPressBlockKey;

@implementation UIView (FYBlockGesture)

- (void)fy_tapBlock:(FYGestureBlock)block {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(p_handleTapGesture:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, &fy_kFYTapBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        FYGestureBlock block = objc_getAssociatedObject(self, &fy_kFYTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}


- (void)fy_longPressBlock:(FYGestureBlock)block {
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
            initWithTarget:self action:@selector(p_handleLongPressGesture:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, &fy_kFYLongPressBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        FYGestureBlock block = objc_getAssociatedObject(self, &fy_kFYLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}


@end
