#import "FavouriteMoviesStorage.h"


@implementation FavouriteMoviesStorage
RCT_EXPORT_MODULE()

- (NSNumber *)multiply:(double)a b:(double)b {
    if(a > 5) {
        [[FavouriteMoviesStorageManager shared] addFavouriteID: 12345];
    }
    if(a > 10) {
        [[FavouriteMoviesStorageManager shared] addFavouriteID: 322444];
    }
    
    if(a > 100) {
       const auto rez =  [[FavouriteMoviesStorageManager shared] fetchAllFavouriteIDs];
        return rez[0];
    }
    return 0;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeFavouriteMoviesStorageSpecJSI>(params);
}

@end
