#import "FavouriteMoviesStorage.h"
#import "react_native_movie_list-Swift.h" // Import the generated Swift header

@implementation FavouriteMoviesStorage
RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeFavouriteMoviesStorageSpecJSI>(params);
}


- (NSArray<NSDictionary *> *)getFavouriteMovies {
    NSArray *movies = [[FavouriteMoviesManager shared] fetchAllFavouriteMoviesAsList];
    NSMutableArray *result = [NSMutableArray array];
    for (IntermediateFavouriteMovie *movie in movies) {
        [result addObject:@{
            @"id": @(movie.id),
            @"url": movie.url,
            @"status": movie.status,
            @"title": movie.title,
            @"rating": movie.rating
        }];
    }
    return result;
}

- (void)removeAllFavouriteMovies:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    [[FavouriteMoviesManager shared] removeAllFavouriteMoviesOnSuccess:^{
        resolve(@YES);
    } onError:^(NSError * _Nonnull error) {
        reject(@"remove_all_favourite_movies_error", error.localizedDescription, error);
    }];
}

- (void)removeFavouriteMovie:(double)movieId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if (movieId < NSIntegerMin || movieId > NSIntegerMax || floor(movieId) != movieId) {
           reject(@"invalid_id", @"The provided ID is invalid", nil);
           return;
       }

    NSInteger intMovieId = (NSInteger)movieId;
    [[FavouriteMoviesManager shared] removeFavouriteMovieByID:intMovieId onSuccess:^(NSArray<IntermediateFavouriteMovie *> * _Nonnull movies) {
        NSMutableArray *result = [NSMutableArray array];
        for (IntermediateFavouriteMovie *movie in movies) {
            [result addObject:@{
                @"id": @(movie.id),
                @"url": movie.url,
                @"status": movie.status,
                @"title": movie.title,
                @"rating": movie.rating
            }];
        }
        resolve(result);
    } onError:^(NSError * _Nonnull error) {
        reject(@"remove_favourite_movie_error", error.localizedDescription, error);
    }];
}

- (void)addFavouriteMovie:(JS::NativeFavouriteMoviesStorage::FavouriteMovie &)movie resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    NSDictionary *movieDict = @{
        @"id": @(movie.id_()),
        @"url": movie.url(),
        @"status": movie.status(),
        @"title": movie.title(),
        @"rating": movie.rating()
    };
    
    IntermediateFavouriteMovie *swiftMovie = [[IntermediateFavouriteMovie alloc] initWithId:[movieDict[@"id"] intValue]
                                                                                        url:movieDict[@"url"]
                                                                                     status:movieDict[@"status"]
                                                                                      title:movieDict[@"title"]
                                                                                     rating:movieDict[@"rating"]];
    
    [[FavouriteMoviesManager shared] addFavouriteMovie:swiftMovie onSuccess:^(NSArray<IntermediateFavouriteMovie *> * _Nonnull movies) {
        NSMutableArray *result = [NSMutableArray array];
        for (IntermediateFavouriteMovie *movie in movies) {
            [result addObject:@{
                @"id": @(movie.id),
                @"url": movie.url,
                @"status": movie.status,
                @"title": movie.title,
                @"rating": movie.rating
            }];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            resolve(result);
        });
    } onError:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            reject(@"add_favourite_movie_error", error.localizedDescription, error);
        });
    }];
    
}

@end
