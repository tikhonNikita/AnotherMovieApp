
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNMovieList/RNMovieList.h"

@interface FavouriteMoviesStorage : NSObject <NativeFavouriteMoviesStorageSpec>
#else
#import <React/RCTBridgeModule.h>

@interface FavouriteMoviesStorage : NSObject <RCTBridgeModule>
#endif

@end
