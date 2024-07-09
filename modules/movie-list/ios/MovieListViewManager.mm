#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface MovieListViewManager : RCTViewManager
@end

@implementation MovieListViewManager

RCT_EXPORT_MODULE(MovieListView)
RCT_EXPORT_VIEW_PROPERTY(color, NSArray)

@end
