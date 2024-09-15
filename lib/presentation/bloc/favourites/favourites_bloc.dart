import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clothing/domain/repositories/favourites_repository.dart';
import 'package:meta/meta.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouritesRepository favouritesRepository;
  FavouritesBloc(this.favouritesRepository)
      : super(FavouritesState(favourites: {})) {
    on<ToggleFavouritesEvent>(toggleFavouritesEvent);
    on<DeleteFavItemEvent>(deleteFavItemEvent);
    on<FetchFavouritesEvent>(fetchFavouritesEvent);
  }


  FutureOr<void> toggleFavouritesEvent(
      ToggleFavouritesEvent event, Emitter<FavouritesState> emit) async {
    final favourites = Map<String, bool>.from(state.favourites); // Copy of current favourites map
    try {
      final isFavourite = favourites[event.productId] ?? false;
      final newFavouriteStatus = !isFavourite;

      if (newFavouriteStatus) {
        // Add to favourites
        await favouritesRepository.addToFavourites(
          event.productId,
          event.productName,
          event.price,
          event.image,
        );
      } else {
        // Remove from favourites
        await favouritesRepository.deleteFavItem(event.productId);
      }

      // Update the map with the new status
      favourites[event.productId] = newFavouriteStatus;

      // Emit the updated state with the new favourites map
      emit(FavouritesState(favourites: favourites));
    } catch (e) {
      emit(FavouritesState(favourites: favourites)); // Emit state even in case of error
      print('Error toggling favourite: $e');
    }
  }

  // This method checks if a product is a favourite based on the current state
  bool isProductFavourite(String productId) {
    return state.favourites[productId] ?? false;
  }

  FutureOr<void> deleteFavItemEvent(
      DeleteFavItemEvent event, Emitter<FavouritesState> emit) async {
    try {
      await favouritesRepository.deleteFavItem(event.docId);
      
      // Remove the item from the favourites map after deletion
      final favourites = Map<String, bool>.from(state.favourites);
      favourites.remove(event.docId);
      emit(FavouritesState(favourites: favourites));
    } catch (e) {
      print('Error deleting favourite: $e');
    }
  }

  FutureOr<void> fetchFavouritesEvent(FetchFavouritesEvent event, Emitter<FavouritesState> emit)async {

    try{
      final favourites = await favouritesRepository.getFavourites();
    emit(FavouritesState(favourites: favourites));
    }catch(e){
       print('Error fetching favourites: $e');
    }
  }
}
